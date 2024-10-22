CREATE PROCEDURE [dbo].[usp_Select_All_Messages_By_Modulo] (
	@JSON_IN VARCHAR(MAX) = NULL,
	@JSON_OUT VARCHAR(MAX) OUTPUT
)
AS
BEGIN
	DECLARE @resp_JSON_Consolidada NVARCHAR(MAX);
	DECLARE @Resp_1 NVARCHAR(MAX);
	DECLARE @p_Nombre_Modulo VARCHAR(MAX);
	DECLARE @ROWS NVARCHAR(MAX);

		-- Verificar si el JSON es válido
		IF (@JSON_IN IS NULL OR @JSON_IN = '' OR ISJSON(@JSON_IN) <> 1)
		BEGIN
			-- Respuesta cuando el JSON es nulo o inválido
			SELECT @resp_JSON_Consolidada = (
				SELECT @@ROWCOUNT AS ROWS_AFFECTED,
					CAST(0 AS BIT) AS SUCCESS,
					'Error' AS ERROR_TITLE_SP,
					'Error, se recibió el JSON vacío o inválido' AS ERROR_MESSAGE_SP,
					ERROR_NUMBER() AS ERROR_NUMBER_SP,
					NULL AS ID,
					NULL AS ROW
				FOR JSON PATH, INCLUDE_NULL_VALUES
			);

			SET @JSON_OUT = @resp_JSON_Consolidada;
			RETURN;
		END

		SET @JSON_IN = REPLACE(@JSON_IN, '\', '');

		-- Extract 'Nombre' from the JSON input
		SELECT @p_Nombre_Modulo = Nombre 
		FROM OPENJSON(@JSON_IN) WITH (Nombre VARCHAR(MAX));

		-- Validate that the module exists
		IF NOT EXISTS (SELECT 1 FROM MensajesEmergentesModulo WHERE Modulo = @p_Nombre_Modulo)
		BEGIN
			-- Response if the module does not exist
			SELECT @resp_JSON_Consolidada = (
				SELECT @@ROWCOUNT AS ROWS_AFFECTED,
					CAST(0 AS BIT) AS SUCCESS,
					'Ocurrió un problema!' AS ERROR_TITLE_SP,
					CONCAT(ERROR_MESSAGE(), 'El nombre del modulo no existe, por lo que no se pudieron obtener todos los mensajes del modulo solicitado para poder insertar, modificar e eliminar registros!') AS ERROR_MESSAGE_SP,
					ERROR_NUMBER() AS ERROR_NUMBER_SP,
					NULL AS ID,
					NULL AS ROW
				FOR JSON PATH, INCLUDE_NULL_VALUES
			);

			SET @JSON_OUT = (SELECT @resp_JSON_Consolidada);
			RETURN;
		END

		BEGIN TRY
			BEGIN TRANSACTION OBTENER;

			-- Fetch the messages associated with the module
			SELECT @ROWS = (
				SELECT
					TM.Id AS Id_Tipo_Mensaje,
					TM.TipoMensaje,
					MET.Id AS Id_Metodo,
					MET.Metodo,
					T.Id AS Id_Titulo,
					T.Titulo,
					ME.Id AS Id_Mensaje,
					ME.Mensaje,
					ME.ErrorMensaje
				FROM MensajesEmergentes ME
				INNER JOIN MensajesEmergentesMetodo MET ON ME.Fk_Metodo = MET.Id
				INNER JOIN MensajesEmergentesModulo MO ON ME.Fk_Modulo = MO.Id
				INNER JOIN MensajesEmergentesTipo TM ON ME.Fk_TipoMensaje = TM.Id
				INNER JOIN MensajesEmergentesTitulo T ON ME.Fk_Titulo = T.Id
				WHERE MO.Modulo = ISNULL(@p_Nombre_Modulo, MO.Modulo)
				FOR JSON PATH, INCLUDE_NULL_VALUES
			);

			-- Successful response
			SELECT @Resp_1 = (
				SELECT @@ROWCOUNT AS ROWS_AFFECTED,
					CAST(1 AS BIT) AS SUCCESS,
					'Exitoso' AS ERROR_TITLE_SP,
					'Mensajes obtenidos con exito!' AS ERROR_MESSAGE_SP,
					NULL AS ERROR_NUMBER_SP,
					NULL AS ID,
					@ROWS AS ROW
				FOR JSON PATH, INCLUDE_NULL_VALUES
			);

			-- Clean up JSON output
			SET @resp_JSON_Consolidada = REPLACE(@Resp_1, ':"[{\', ':[{');
			SET @resp_JSON_Consolidada = REPLACE(@resp_JSON_Consolidada, '\"}]"', '\"}]');
			SET @resp_JSON_Consolidada = REPLACE(@resp_JSON_Consolidada, 'null}]","', 'null}],"');
			SET @resp_JSON_Consolidada = REPLACE(@resp_JSON_Consolidada, ':\"\"}]","', ':\"\"}],"');
			SET @resp_JSON_Consolidada = REPLACE(@resp_JSON_Consolidada, 'null}]"}]', 'null}]}]');
			SET @resp_JSON_Consolidada = REPLACE(@resp_JSON_Consolidada, '\', '');

			SET @JSON_OUT = (SELECT @resp_JSON_Consolidada);

			-- Commit the transaction if successful
			IF @@TRANCOUNT > 0
			BEGIN
				COMMIT TRANSACTION OBTENER;
			END
		END TRY
		BEGIN CATCH
			-- Error handling and response
			SELECT @resp_JSON_Consolidada = (
				SELECT @@ROWCOUNT AS ROWS_AFFECTED,
					CAST(0 AS BIT) AS SUCCESS,
					'Ocurrió un problema!' AS ERROR_TITLE_SP,
					CONCAT(ERROR_MESSAGE(), 'No se pudieron obtener todos los mensajes del modulo solicitado, para poder insertar, modificar e eliminar registros!') AS ERROR_MESSAGE_SP,
					ERROR_NUMBER() AS ERROR_NUMBER_SP,
					NULL AS ID,
					NULL AS ROW
				FOR JSON PATH, INCLUDE_NULL_VALUES
			);

			SET @JSON_OUT = (SELECT @resp_JSON_Consolidada);

			-- Rollback if any error occurred
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION OBTENER;
			END
		END CATCH
END
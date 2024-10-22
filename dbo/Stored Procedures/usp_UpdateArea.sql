CREATE   PROCEDURE [dbo].[usp_UpdateArea] (@ID INT, @NOMBRE NVARCHAR(MAX) = NULL,  @ACTIVO BIT = NULL)
AS
BEGIN
	---Declaracion Variables
    DECLARE @MetodoTemporal NVARCHAR(MAX) = 'usp_UpdateArea';
	DECLARE @IdDato INT = -1;


		DECLARE @ROWS_AFFECTED INT = 0;
    DECLARE @SUCCESS BIT = 0;
    DECLARE @ERROR_NUMBER_SP NVARCHAR(MAX) = NULL;
    DECLARE @CONSTRAINT_TRIGGER_NAME NVARCHAR(MAX) = NULL;
    DECLARE @ROW NVARCHAR(MAX) = NULL;
    DECLARE @TipoMensaje NVARCHAR(MAX) = 'Error';
    DECLARE @ErrorMensaje NVARCHAR(MAX) = NULL;
    DECLARE @ModeJson BIT = 0;
	
	BEGIN TRY
		---
			UPDATE Area SET Nombre = ISNULL(@NOMBRE, Nombre),Activo = ISNULL(@ACTIVO, Activo) WHERE Id = @ID
		---

				-- Captura el número de filas afectadas y otros detalles
        SET @ROWS_AFFECTED = @@ROWCOUNT;
        SET @SUCCESS = 1;
        SET @TipoMensaje = 'Exitoso';

		SET @ROW  = (SELECT       A.Id							AS [Id]
												 , A.Nombre						AS [Nombre]										
												 , A.Activo						AS [Activo]
												 , A.FechaCreacion				AS [FechaCreacion]
												 , A.FechaModificacion			AS [FechaModificacion]


										FROM Area A WHERE A.Id = @ID FOR JSON PATH)

		SET @IdDato = CONVERT(INT, ISNULL(SCOPE_IDENTITY(), -1));
		---
		---
	END TRY    
	BEGIN CATCH

				SET @ROWS_AFFECTED = 0;
			 	SET @ErrorMensaje = ERROR_MESSAGE();
				SET @ERROR_NUMBER_SP = ERROR_NUMBER();
				SET @CONSTRAINT_TRIGGER_NAME = ERROR_PROCEDURE();
				SET @TipoMensaje = 'Error';
				SET @SUCCESS = 0;
		--
		--    
	END CATCH
	---
	
		   -- Llamada al procedimiento que maneja mensajes emergentes (una sola vez)
    EXEC usp_Select_MensajesEmergentes_Para_SP 
        @ROWS_AFFECTED = @ROWS_AFFECTED,
        @SUCCESS = @SUCCESS,
        @ERROR_NUMBER_SP = @ERROR_NUMBER_SP,
        @CONSTRAINT_TRIGGER_NAME = @CONSTRAINT_TRIGGER_NAME,
        @ID = @IdDato,
        @ROW = NULL,
        @Metodo = @MetodoTemporal, 
        @TipoMensaje = @TipoMensaje, 
        @ErrorMensaje = @ErrorMensaje,
        @ModeJson = 0;

END
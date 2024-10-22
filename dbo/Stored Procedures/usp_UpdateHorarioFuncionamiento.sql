CREATE   PROCEDURE [dbo].[usp_UpdateHorarioFuncionamiento](
  @DIA											INT
, @ID											INT
, @ACTIVO										BIT
, @HORA_DESDE									TIME
, @HORA_HASTA									TIME
)
AS
BEGIN
	---
	BEGIN TRY
		---
			IF(@HORA_HASTA is null)
		BEGIN
			SET @HORA_HASTA = '23:59:00'
		END

		IF(@HORA_DESDE is null)
		BEGIN
			SET @HORA_HASTA = '00:00:00'
		END

			DECLARE @ROW NVARCHAR(MAX)
			DECLARE @DIASEMANA INT
			DECLARE @AACTUAL BIT
			DECLARE @ERROR NVARCHAR(MAX)
			DECLARE @ERROR_NAME NVARCHAR(MAX)
			DECLARE @Central_America NVARCHAR(MAX) = 'Central America Standard Time';


			SET @DIASEMANA = (select DATEPART(weekday, getdate()) as DiadelaSemana) - 1

			DECLARE @TIME TIME = (SELECT CONVERT(TIME, GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE @Central_America) AS HORAACTUAL)
			
			--Dentro del ranho hora desde no se puede
			DECLARE @HORA INT = (SELECT COUNT(*) FROM HorarioFuncionamiento WHERE  @TIME BETWEEN HoraInicio AND HoraFinal  and HoraInicio <> @HORA_DESDE AND Id = @ID)		
			
			
			--Fuera del horario solo adelantar y antes de la hora hasta
			DECLARE @HDESDE INT = (SELECT COUNT(*) FROM HorarioFuncionamiento WHERE  @HORA_DESDE > HoraFinal and HoraInicio <> @HORA_DESDE AND Id = @ID)


				--Fuera del horario solo adelantar y antes de la hora hasta
			
			DECLARE @HDESDE_CORTE INT = (SELECT COUNT(*) FROM HorarioFuncionamiento WHERE  @HORA_DESDE < HoraInicio AND @TIME < HoraFinal AND @TIME > @HORA_DESDE  AND Id = @ID)
																							--	16:02 <	16:04  AND 16:01 < 16:05 and 16:05 > 16:02


			
			-- El hasta si la hora actual es mayor que la hora hasta definida no se puede modificar
			DECLARE @HHASTA INT = (SELECT COUNT(*) FROM HorarioFuncionamiento WHERE @TIME > HoraFinal and HoraFinal <> @HORA_HASTA AND Id = @ID)

			-- El hasta si la hora actual es mayor que la hora hasta definida no se puede modificar
			DECLARE @HHASTA_DRANGO INT = (SELECT COUNT(*) FROM HorarioFuncionamiento WHERE @TIME > @HORA_HASTA AND  @TIME < HoraFinal and HoraFinal <> @HORA_HASTA AND Id = @ID)
			

			SET @ROW  = (SELECT * FROM HorarioFuncionamiento WHERE Dia = @DIA AND Id = @ID FOR JSON PATH)

			IF @DIA = @DIASEMANA
				BEGIN
					declare @DA_HCOMPRENDIDO INT =	(SELECT COUNT(*) FROM HorarioFuncionamiento WHERE Dia = @DIA AND Id = @ID and @TIME BETWEEN HoraInicio AND HoraFinal)
					
					--hORARIO DENTRO DEL RANGO DEL MISMO DIA
					IF  @DA_HCOMPRENDIDO > 0					
						BEGIN
						SET @AACTUAL =	(SELECT Activo FROM HorarioFuncionamiento WHERE Dia = @DIA AND Id = @ID)					
						--CAMBIAR ESTADO
						IF  @AACTUAL <> @ACTIVO
						BEGIN
							SET @ERROR = 'Check_Dia_Actual'
							SET @ERROR_NAME = 'Los días de funcionamiento de la herramienta no se pueden habilitar o deshabilitar en el trascurso del horario de funcionamiento del mismo día'

								SELECT  CAST(0 AS BIT)										AS SUCCESS
									, @ERROR_NAME											AS ERROR_MESSAGE_SP
									, @ERROR											AS CONSTRAINT_TRIGGER_NAME
									, ERROR_NUMBER()											AS ERROR_NUMBER_SP
									, 0															AS ROWS_AFFECTED
									, -1														AS ID
									, @ROW														AS ROW

						END	
						
						--MODIFICAR HORA DESDE
						ELSE IF @HORA > 0
						BEGIN
							SET @ERROR = 'Check_Hora_Desde_Hasta_Mismo_Dia'
							SET @ERROR_NAME = 'La hora desde no se puede modificar en el trascurso del horario de funcionamiento del mismo día'

							SELECT  CAST(0 AS BIT)										AS SUCCESS
									, @ERROR_NAME											AS ERROR_MESSAGE_SP
									, @ERROR											AS CONSTRAINT_TRIGGER_NAME
									, ERROR_NUMBER()											AS ERROR_NUMBER_SP
									, 0															AS ROWS_AFFECTED
									, -1														AS ID
									, @ROW														AS ROW
						END						

						-- MODIFICAR HHASTA DENTRO DEL RANGO PERO DEBE SER MAYOR QUE LA HORA ACTUAL
						ELSE IF  @HHASTA_DRANGO > 0
						BEGIN
							SET @ERROR = 'Check_Hora_Hasta_Mismo_Dia'
							SET @ERROR_NAME = 'La hora hasta siempre debe ser configurada en un valor posterior a la hora del momento en el que se hace la modificación. '

							SELECT  CAST(0 AS BIT)										AS SUCCESS
									, @ERROR_NAME											AS ERROR_MESSAGE_SP
									, @ERROR											AS CONSTRAINT_TRIGGER_NAME
									, ERROR_NUMBER()											AS ERROR_NUMBER_SP
									, 0															AS ROWS_AFFECTED
									, -1														AS ID
									, @ROW														AS ROW
						END

						-- SE ACTUALIZA SI NO SE CUMPLE NINGUNA ANTERIOR
						ELSE
						BEGIN
					
							UPDATE HorarioFuncionamiento SET
							  Activo		=		@ACTIVO,
							  HoraInicio	=		@HORA_DESDE,
							  HoraFinal		=		@HORA_HASTA
							  WHERE Dia = @DIA AND Id = @ID

		
					---
							SELECT	  @@ROWCOUNT												AS ROWS_AFFECTED
									, CAST(1 AS BIT)											AS SUCCESS
									, ''														AS ERROR_MESSAGE_SP
									, ''														AS CONSTRAINT_TRIGGER_NAME
									, NULL														AS ERROR_NUMBER_SP
									, CONVERT(INT, ISNULL(SCOPE_IDENTITY(), -1))				AS ID
									, @ROW														AS ROW
					END


					END		
								
					-- HORARIO FUERA DEL RANGO EL HASTA NO SE PUEDE CAMBIAR
					ELSE IF  @HHASTA > 0
						BEGIN
							SET @ERROR = 'Check_Hora_Hasta_Mismo_Dia'
							SET @ERROR_NAME = 'La hora hasta no puede ser configurada posterior a la hora de ciere del dia en curso.'

							SELECT  CAST(0 AS BIT)										AS SUCCESS
									, @ERROR_NAME											AS ERROR_MESSAGE_SP
									, @ERROR											AS CONSTRAINT_TRIGGER_NAME
									, ERROR_NUMBER()											AS ERROR_NUMBER_SP
									, 0															AS ROWS_AFFECTED
									, -1														AS ID
									, @ROW														AS ROW
						END
					
			
					-- HORARIO FUERA DEL RANGO EL DESDE SE PUEDE CAMBIAR SIEMPRE QEU SEA MAYOR A LA HORA ACTUAL 
					ELSE IF @HDESDE > 0 OR @HDESDE_CORTE > 0
						BEGIN

							

							SET @ERROR = 'Check_Hora_Desde_Mismo_Dia'
							SET @ERROR_NAME = 'La hora desde siempre debe ser configurada en un valor posterior a la hora del momento en el que se hace la modificación'

							SELECT  CAST(0 AS BIT)										AS SUCCESS
									, @ERROR_NAME											AS ERROR_MESSAGE_SP
									, @ERROR											AS CONSTRAINT_TRIGGER_NAME
									, ERROR_NUMBER()											AS ERROR_NUMBER_SP
									, 0															AS ROWS_AFFECTED
									, -1														AS ID
									, @ROW														AS ROW
						END
					ELSE
						BEGIN
					
						UPDATE HorarioFuncionamiento SET
						  Activo		=		@ACTIVO,
						  HoraInicio	=		@HORA_DESDE,
						  HoraFinal		=		@HORA_HASTA,
						  FechaModificacion = GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE @Central_America
						  WHERE Dia = @DIA AND Id = @ID

		
				---
						SELECT	  @@ROWCOUNT												AS ROWS_AFFECTED
								, CAST(1 AS BIT)											AS SUCCESS
								, ''														AS ERROR_MESSAGE_SP
								, ''														AS CONSTRAINT_TRIGGER_NAME
								, NULL														AS ERROR_NUMBER_SP
								, CONVERT(INT, ISNULL(SCOPE_IDENTITY(), -1))				AS ID
								, @ROW														AS ROW
					END
					
				END
			ELSE
				BEGIN
					IF @ACTIVO = 1
					BEGIN
					UPDATE HorarioFuncionamiento SET
					  Activo		=		@ACTIVO,
					  HoraInicio	=		@HORA_DESDE,
					  HoraFinal		=		@HORA_HASTA,
					  FechaModificacion = GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE @Central_America
					WHERE Dia = @DIA AND Id = @ID
					END
					ELSE
					BEGIN
					UPDATE HorarioFuncionamiento SET
					  Activo		=		@ACTIVO,
					  HoraInicio	=		ISNULL('00:00:00',@HORA_DESDE),
					  HoraFinal		=		ISNULL('23:59:00',@HORA_HASTA),
					  FechaModificacion = GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE @Central_America
					WHERE Dia = @DIA AND Id = @ID
					END
		
				---
				SELECT	  @@ROWCOUNT												AS ROWS_AFFECTED
						, CAST(1 AS BIT)											AS SUCCESS
						, 'Se actualizó correctamente el área' 					AS ERROR_MESSAGE_SP
						, ''														AS CONSTRAINT_TRIGGER_NAME
						, NULL														AS ERROR_NUMBER_SP
						, CONVERT(INT, ISNULL(SCOPE_IDENTITY(), -1))				AS ID
						, @ROW														AS ROW

			END

		
	
		---
	END TRY    
	BEGIN CATCH	
		SET @ROW  = (SELECT * FROM HorarioFuncionamiento WHERE Dia = @DIA AND Id = @ID FOR JSON PATH)

		--
		---
		DECLARE @ERROR_MESSAGE NVARCHAR(MAX) 
		SET @ERROR_MESSAGE = ERROR_MESSAGE() 
		---
		DECLARE @CONSTRAINT_NAME NVARCHAR(MAX) = ''
		DECLARE @CONSTRAINT_NAME1 NVARCHAR(MAX) = '%CK_checkHoraHastaDesdeNotNull%'
		DECLARE @CONSTRAINT_NAME2 NVARCHAR(MAX) = '%CK_CheckHoraDesdeHastaValido%'
		---
		DECLARE @NOMBRE_DIA NVARCHAR(MAX) = (SELECT top 1 NombreDia FROM HorarioFuncionamiento WHERE Dia = @DIA)
		--
		IF @ERROR_MESSAGE LIKE @CONSTRAINT_NAME1 
		BEGIN 
			---
			SET @CONSTRAINT_NAME = 'Check_Hora_Desde_Hasta_Not_Null'
			SET @ERROR_MESSAGE = 'Al seleccionar el día ' + @NOMBRE_DIA + ' como dia hábil para el funcionamiento del motor, debe seleccionar la hora DESDE Y HASTA'
			---
		END
		ELSE IF @ERROR_MESSAGE LIKE @CONSTRAINT_NAME2 
		BEGIN 
			---
			SET @CONSTRAINT_NAME = 'Check_Rango_Hora_Desde_Hasta_Valido'
			SET @ERROR_MESSAGE = 'La hora hasta no puede ser previa a la hora desde'
			---
		END
		--		
		--
		SELECT  CAST(0 AS BIT)												AS SUCCESS
				, @ERROR_MESSAGE											AS ERROR_MESSAGE_SP
				, @CONSTRAINT_NAME											AS CONSTRAINT_TRIGGER_NAME
				, ERROR_NUMBER()											AS ERROR_NUMBER_SP
				, 0															AS ROWS_AFFECTED
				, -1														AS ID
				, @ROW														AS ROW
		

		--
	END CATCH
	---
END
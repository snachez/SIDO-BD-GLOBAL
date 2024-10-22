-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- I N S E R T		D E		D A T O S
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------
-- I N S E R T	-	[ H o r a r i o F u n c i o n a m i e n t o]
-----------------------------------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA  = 'dbo' AND TABLE_NAME = 'HorarioFuncionamiento')
BEGIN
	SET IDENTITY_INSERT [dbo].[HorarioFuncionamiento] ON 

	DECLARE @HORA_INICIO VARCHAR(8) = '00:00:00'
	DECLARE @HORA_FINAL VARCHAR(8) = '23:59:00'

	-- Lunes
	IF NOT EXISTS (SELECT 1 FROM [dbo].[HorarioFuncionamiento] WHERE [Id] = 1)
	BEGIN
		INSERT INTO [dbo].[HorarioFuncionamiento] 
			([Id], [Dia], [NombreDia], [HoraInicio], [HoraFinal], [FechaCreacion], [FechaModificacion], [Activo])
		VALUES 
			(1, 1, N'Lunes', CAST(@HORA_INICIO AS Time), CAST(@HORA_FINAL AS Time), CURRENT_TIMESTAMP, NULL, 1);
	END

	-- Martes
	IF NOT EXISTS (SELECT 1 FROM [dbo].[HorarioFuncionamiento] WHERE [Id] = 2)
	BEGIN
		INSERT INTO [dbo].[HorarioFuncionamiento] 
			([Id], [Dia], [NombreDia], [HoraInicio], [HoraFinal], [FechaCreacion], [FechaModificacion], [Activo])
		VALUES 
			(2, 2, N'Martes', CAST(@HORA_INICIO AS Time), CAST(@HORA_FINAL AS Time), CURRENT_TIMESTAMP, NULL, 0);
	END

	-- Miércoles
	IF NOT EXISTS (SELECT 1 FROM [dbo].[HorarioFuncionamiento] WHERE [Id] = 3)
	BEGIN
		INSERT INTO [dbo].[HorarioFuncionamiento] 
			([Id], [Dia], [NombreDia], [HoraInicio], [HoraFinal], [FechaCreacion], [FechaModificacion], [Activo])
		VALUES 
			(3, 3, N'Miércoles', CAST(@HORA_INICIO AS Time), CAST(@HORA_FINAL AS Time), CURRENT_TIMESTAMP, NULL, 0);
	END

	-- Jueves
	IF NOT EXISTS (SELECT 1 FROM [dbo].[HorarioFuncionamiento] WHERE [Id] = 4)
	BEGIN
		INSERT INTO [dbo].[HorarioFuncionamiento] 
			([Id], [Dia], [NombreDia], [HoraInicio], [HoraFinal], [FechaCreacion], [FechaModificacion], [Activo])
		VALUES 
			(4, 4, N'Jueves', CAST(@HORA_INICIO AS Time), CAST(@HORA_FINAL AS Time), CURRENT_TIMESTAMP, NULL, 1);
	END

	-- Viernes
	IF NOT EXISTS (SELECT 1 FROM [dbo].[HorarioFuncionamiento] WHERE [Id] = 5)
	BEGIN
		INSERT INTO [dbo].[HorarioFuncionamiento] 
			([Id], [Dia], [NombreDia], [HoraInicio], [HoraFinal], [FechaCreacion], [FechaModificacion], [Activo])
		VALUES 
			(5, 5, N'Viernes', CAST(@HORA_INICIO AS Time), CAST(@HORA_FINAL AS Time), CURRENT_TIMESTAMP, NULL, 0);
	END

	-- Sábado
	IF NOT EXISTS (SELECT 1 FROM [dbo].[HorarioFuncionamiento] WHERE [Id] = 6)
	BEGIN
		INSERT INTO [dbo].[HorarioFuncionamiento] 
			([Id], [Dia], [NombreDia], [HoraInicio], [HoraFinal], [FechaCreacion], [FechaModificacion], [Activo])
		VALUES 
			(6, 6, N'Sábado', CAST(@HORA_INICIO AS Time), CAST(@HORA_FINAL AS Time), CURRENT_TIMESTAMP, NULL, 0);
	END

	-- Domingo
	IF NOT EXISTS (SELECT 1 FROM [dbo].[HorarioFuncionamiento] WHERE [Id] = 7)
	BEGIN
		INSERT INTO [dbo].[HorarioFuncionamiento] 
			([Id], [Dia], [NombreDia], [HoraInicio], [HoraFinal], [FechaCreacion], [FechaModificacion], [Activo])
		VALUES 
			(7, 7, N'Domingo', CAST(@HORA_INICIO AS Time), CAST(@HORA_FINAL AS Time), CURRENT_TIMESTAMP, NULL, 0);
	END

	SET IDENTITY_INSERT [dbo].[HorarioFuncionamiento] OFF
END
---
-----------------------------------------------------------------------------------------------------
-- I N S E R T	-	[ M e ns a j e s E m e r g e n t e s M e t o d o]		-		M E T A D A T A
-----------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA  = 'dbo' AND TABLE_NAME = 'MensajesEmergentesMetodo')
BEGIN
	SET IDENTITY_INSERT [dbo].[MensajesEmergentesMetodo] ON 

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesMetodo] WHERE [Id] = 1)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesMetodo] ([Id], [Metodo], [FechaCreacion], [FechaModificacion])
		VALUES (1, N'usp_InsertArea', CURRENT_TIMESTAMP, NULL);
	END
	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesMetodo] WHERE [Id] = 2)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesMetodo] ([Id], [Metodo], [FechaCreacion], [FechaModificacion])
		VALUES (2, N'usp_UpdateArea', CURRENT_TIMESTAMP, NULL);
	END
	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesMetodo] WHERE [Id] = 3)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesMetodo] ([Id], [Metodo], [FechaCreacion], [FechaModificacion])
		VALUES (3, N'RequestValido()', CURRENT_TIMESTAMP, NULL);
	END
	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesMetodo] WHERE [Id] = 4)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesMetodo] ([Id], [Metodo], [FechaCreacion], [FechaModificacion])
		VALUES (4, N'Insertar()', CURRENT_TIMESTAMP, NULL);
	END
	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesMetodo] WHERE [Id] = 5)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesMetodo] ([Id], [Metodo], [FechaCreacion], [FechaModificacion])
		VALUES (5, N'Update()', CURRENT_TIMESTAMP, NULL);
	END
	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesMetodo] WHERE [Id] = 6)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesMetodo] ([Id], [Metodo], [FechaCreacion], [FechaModificacion])
		VALUES (6, N'SP_HistoricoRevisiones_Catalogos', CURRENT_TIMESTAMP, NULL);
	END

	SET IDENTITY_INSERT [dbo].[MensajesEmergentesMetodo] OFF
END
GO
---
-----------------------------------------------------------------------------------------------------
-- I N S E R T	-	[ M e ns a j e s E m e r g e n t e s M o d u l o]		-		M E T A D A T A
-----------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA  = 'dbo' AND TABLE_NAME = 'MensajesEmergentesModulo')
BEGIN
	SET IDENTITY_INSERT [dbo].[MensajesEmergentesModulo] ON 

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesModulo] WHERE [Id] = 1)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesModulo] ([Id], [Modulo], [FechaCreacion], [FechaModificacion])
		VALUES (1, N'Areas', CURRENT_TIMESTAMP, NULL);
	END
	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesModulo] WHERE [Id] = 2)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesModulo] ([Id], [Modulo], [FechaCreacion], [FechaModificacion])
		VALUES (2, N'Histórico de Revisiones', CURRENT_TIMESTAMP, NULL);
	END


	SET IDENTITY_INSERT [dbo].[MensajesEmergentesModulo] OFF
END
GO
---
-----------------------------------------------------------------------------------------------------
-- I N S E R T	-	[ M e ns a j e s E m e r g e n t e s T i p o M e n s a j e]		-		M E T A D A T A
-----------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA  = 'dbo' AND TABLE_NAME = 'MensajesEmergentesTipo')
BEGIN
	SET IDENTITY_INSERT [dbo].[MensajesEmergentesTipo] ON 

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTipo] WHERE [Id] = 1)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTipo] ([Id], [TipoMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (1, N'Exitoso', CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTipo] WHERE [Id] = 2)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTipo] ([Id], [TipoMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (2, N'Error', CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTipo] WHERE [Id] = 3)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTipo] ([Id], [TipoMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (3, N'Confirmacion', CURRENT_TIMESTAMP, NULL);
	END


	SET IDENTITY_INSERT [dbo].[MensajesEmergentesTipo] OFF
END
GO
---
-----------------------------------------------------------------------------------------------------
-- I N S E R T	-	[ M e ns a j e s E m e r g e n t e s T i t u l o]		-		M E T A D A T A
-----------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA  = 'dbo' AND TABLE_NAME = 'MensajesEmergentesTitulo')
BEGIN
	SET IDENTITY_INSERT [dbo].[MensajesEmergentesTitulo] ON 

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTitulo] WHERE [Id] = 1)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTitulo] ([Id], [Titulo], [FechaCreacion], [FechaModificacion])
		VALUES (1, N'Ocurrió un problema!', CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTitulo] WHERE [Id] = 2)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTitulo] ([Id], [Titulo], [FechaCreacion], [FechaModificacion])
		VALUES (2, N'Actualizado!', CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTitulo] WHERE [Id] = 3)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTitulo] ([Id], [Titulo], [FechaCreacion], [FechaModificacion])
		VALUES (3, N'No Actualizado!', CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTitulo] WHERE [Id] = 4)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTitulo] ([Id], [Titulo], [FechaCreacion], [FechaModificacion])
		VALUES (4, N'Modificado!', CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTitulo] WHERE [Id] = 5)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTitulo] ([Id], [Titulo], [FechaCreacion], [FechaModificacion])
		VALUES (5, N'Modificación', CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTitulo] WHERE [Id] = 6)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTitulo] ([Id], [Titulo], [FechaCreacion], [FechaModificacion])
		VALUES (6, N'Registrado!', CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTitulo] WHERE [Id] = 7)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTitulo] ([Id], [Titulo], [FechaCreacion], [FechaModificacion])
		VALUES (7, N'No registrado!', CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentesTitulo] WHERE [Id] = 8)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentesTitulo] ([Id], [Titulo], [FechaCreacion], [FechaModificacion])
		VALUES (8, N'Creación', CURRENT_TIMESTAMP, NULL);
	END


	SET IDENTITY_INSERT [dbo].[MensajesEmergentesTitulo] OFF
END
GO
---
-----------------------------------------------------------------------------------------------------
-- I N S E R T	-	[ M e ns a j e s E m e r g e n t e s ]		-		M E T A D A T A
-----------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA  = 'dbo' AND TABLE_NAME = 'MensajesEmergentes')
BEGIN
	SET IDENTITY_INSERT [dbo].[MensajesEmergentes] ON 

	DECLARE @VALIDACION_AREA VARCHAR(27) = 'El nombre de área ya existe'
	DECLARE @ERROR_AREA VARCHAR(27) = 't2_C1_Unique_Nombre_Area'

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 1)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (1, 1, 1, 1, 6, N'Se agregó correctamente el área', NULL, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 2)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (2, 1, 1, 2, 1, @VALIDACION_AREA, @ERROR_AREA, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 3)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (3, 1, 2, 1, 2, N'Se actualizó correctamente el área', NULL, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 4)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (4, 1, 2, 2, 1, @VALIDACION_AREA, @ERROR_AREA, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 5)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (5, 1, 1, 1, 6, N'Se agregó correctamente el área', NULL, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 6)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (6, 1, 1, 2, 1, @VALIDACION_AREA, @ERROR_AREA, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 7)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (7, 1, 2, 1, 2, N'Se actualizó correctamente el área', NULL, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 8)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (8, 1, 2, 2, 1, @VALIDACION_AREA, @ERROR_AREA, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 9)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (9, 1, 3, 2, 1, N'El campo Nombre es obligatorio', NULL, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 10)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (10, 1, 5, 3, 5, N'¿Confirma la modificación del area?', NULL, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 11)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (11, 1, 4, 3, 8, N'¿Confirma la creación de la nueva área?', NULL, CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 12)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (12, 2, 6, 2, 1, N'El rango de fechas seleccionado no es valido', N'EVAL_PEXT_Rango_Busqueda_Invalido', CURRENT_TIMESTAMP, NULL);
	END

	IF NOT EXISTS (SELECT 1 FROM [dbo].[MensajesEmergentes] WHERE [Id] = 13)
	BEGIN
		INSERT INTO [dbo].[MensajesEmergentes] ([Id], [Fk_Modulo], [Fk_Metodo], [Fk_TipoMensaje], [Fk_Titulo], [Mensaje], [ErrorMensaje], [FechaCreacion], [FechaModificacion])
		VALUES (13, 2, 6, 2, 1, N'El rango de búsqueda no puede ser superior a', N'EVAL_PEXT_Max_Dias_Permitidos_Busqueda', CURRENT_TIMESTAMP, NULL);
	END


	SET IDENTITY_INSERT [dbo].[MensajesEmergentes] OFF
END
GO
---
-----------------------------------------------------------------------------------------------------
-- I N S E R T	-	[ M e ns a j e s E m e r g e n t e s ]		-		M E T A D A T A
-----------------------------------------------------------------------------------------------------
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA  = 'dbo' AND TABLE_NAME = 'Area')
BEGIN
	SET IDENTITY_INSERT [dbo].[Area] ON 

	IF NOT EXISTS (SELECT 1 FROM [dbo].[Area] WHERE [Id] = 1)
	BEGIN
		INSERT INTO [dbo].[Area] ([Id], [Nombre], [Activo], [FechaCreacion], [FechaModificacion])
		VALUES (1, N'GPC', 1, CURRENT_TIMESTAMP, NULL);
	END

	SET IDENTITY_INSERT [dbo].[Area] OFF
END
GO
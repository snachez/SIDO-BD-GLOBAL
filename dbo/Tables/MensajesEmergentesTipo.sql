--============================================================================
-- Nombre del Objeto: tblMensajesEmergentesTipo.
-- Descripcion:
--		Esta tabla almacena información sobre los tipos de mensajes de la aplicacion web.
-- Objetivo: 
--		Administrar y almacenar información detallada sobre los tipos de mensajes de la aplicacion web.
-- Tipo de Objeto: 
--     Tabla.
-- Motor:
--		MSSQL Server.
-- Origen de los Datos:
--		Datos ingresados por script.
-- Permanencia de Datos:
--		Los datos se almacenan de forma permanente para poder clasificar los tipos mensajes emergentes de la aplicacion web.
-- Uso de los datos:
--		Los datos se utilizan para clasificar los tipos de mensajes emergentes.
-- Restricciones o consideraciones:
--     - No aplican restricciones.
--	Parametros de Entrada y de Salida:
--     No aplicable (ya que es una tabla y no un procedimiento almacenado).
--============================================================================

CREATE TABLE [dbo].[MensajesEmergentesTipo] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [TipoMensaje]       VARCHAR (12)   NOT NULL,
    [FechaCreacion]     SMALLDATETIME  CONSTRAINT [DF_MensajesEmergentesTipo_FechaCreacion] DEFAULT (CONVERT([smalldatetime],getdate())) NOT NULL,
    [FechaModificacion] SMALLDATETIME  NULL,
    CONSTRAINT [PK_MensajesEmergentesTipo] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en que se creó el registro del tipo de mensaje.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesTipo', @level2type = N'COLUMN', @level2name = N'FechaCreacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en que se modificó por última vez el registro del tipo de mensaje.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesTipo', @level2type = N'COLUMN', @level2name = N'FechaModificacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Identificador único de tipo entero para el tipo de mensaje', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesTipo', @level2type = N'COLUMN', @level2name = N'Id';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Nombre que describe el tipo de mensaje.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesTipo', @level2type = N'COLUMN', @level2name = N'TipoMensaje';
GO
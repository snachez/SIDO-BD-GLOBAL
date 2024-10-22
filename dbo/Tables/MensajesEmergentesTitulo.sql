--============================================================================
-- Nombre del Objeto: tblMensajesEmergentesTitulo.
-- Descripcion:
--		Esta tabla almacena información sobre titulos de los mensajes emergentes.
-- Objetivo: 
--		Administrar y almacenar información detallada sobre los titulos de los mensajes de la aplicacion web.
-- Tipo de Objeto: 
--     Tabla.
-- Motor:
--		MSSQL Server.
-- Origen de los Datos:
--		Datos ingresados por script.
-- Permanencia de Datos:
--		Los datos se almacenan de forma permanente para poder visualizar los titulos mensajes emergentes de la aplicacion web.
-- Uso de los datos:
--		Los datos se utilizan para visualizar los titulos de mensajes emergentes.
-- Restricciones o consideraciones:
--     - No aplican restricciones.
--	Parametros de Entrada y de Salida:
--     No aplicable (ya que es una tabla y no un procedimiento almacenado).
--============================================================================


CREATE TABLE [dbo].[MensajesEmergentesTitulo] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Titulo]            VARCHAR (30)   NOT NULL,
    [FechaCreacion]     SMALLDATETIME  CONSTRAINT [DF_MensajesEmergentesTitulo_FechaCreacion] DEFAULT (CONVERT([smalldatetime],getdate())) NOT NULL,
    [FechaModificacion] SMALLDATETIME  NULL,
    CONSTRAINT [PK_MensajesEmergentesTitulo] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en que se creó el registro el titulo del mensaje.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesTitulo', @level2type = N'COLUMN', @level2name = N'FechaCreacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en que se modificó por última vez el registro del titulo del mensaje.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesTitulo', @level2type = N'COLUMN', @level2name = N'FechaModificacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Identificador único de tipo entero para el titulo del mensaje', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesTitulo', @level2type = N'COLUMN', @level2name = N'Id';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Titulo del mensaje emergente.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesTitulo', @level2type = N'COLUMN', @level2name = N'Titulo';
GO
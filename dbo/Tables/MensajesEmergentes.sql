--============================================================================
-- Nombre del Objeto: tblMensajesEmergentes.
-- Descripcion:
--		Esta tabla almacena información sobre los mensajes emergentes que brinda la aplicacion web.
-- Objetivo: 
--		Administrar y almacenar información detallada sobre los mensajes emergentes.
-- Tipo de Objeto: 
--     Tabla.
-- Motor:
--		MSSQL Server.
-- Origen de los Datos:
--		Datos ingresados por script.
-- Permanencia de Datos:
--		Los datos se almacenan de forma permanente para poder mostrar los mensajes emergentes que brinda la aplicacion web.
-- Uso de los datos:
--		Los datos se utilizan para tenerl el control de los mensajes emergentes que brinda la aplicacion web.
-- Restricciones o consideraciones:
--      No existen restricciones
--	Parametros de Entrada y de Salida:
--     No aplicable (ya que es una tabla y no un procedimiento almacenado).
--============================================================================

CREATE TABLE [dbo].[MensajesEmergentes] (
    [Id]                INT           IDENTITY (1, 1) NOT NULL,
    [Fk_Modulo]         INT           NOT NULL,
    [Fk_Metodo]         INT           NOT NULL,
    [Fk_TipoMensaje]    INT           NOT NULL,
    [Fk_Titulo]         INT           NOT NULL,
    [Mensaje]           VARCHAR (200) NOT NULL,
    [ErrorMensaje]      VARCHAR (300) NULL,
    [FechaCreacion]     SMALLDATETIME CONSTRAINT [DF_MensajesEmergentes_FechaCreacion] DEFAULT (CONVERT([smalldatetime],getdate())) NOT NULL,
    [FechaModificacion] SMALLDATETIME NULL,
    CONSTRAINT [PK_MensajesEmergentes] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_MensajesEmergentesMetodo] FOREIGN KEY ([Fk_Metodo]) REFERENCES [dbo].[MensajesEmergentesMetodo] ([Id]),
    CONSTRAINT [FK_MensajesEmergentesModulo] FOREIGN KEY ([Fk_Modulo]) REFERENCES [dbo].[MensajesEmergentesModulo] ([Id]),
    CONSTRAINT [FK_MensajesEmergentesTipoMensaje] FOREIGN KEY ([Fk_TipoMensaje]) REFERENCES [dbo].[MensajesEmergentesTipo] ([Id]),
    CONSTRAINT [FK_MensajesEmergentesTitulo] FOREIGN KEY ([Fk_Titulo]) REFERENCES [dbo].[MensajesEmergentesTitulo] ([Id])
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Error que proporciona en la ventana emergente cado este mensaje no se puede mostrar.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentes', @level2type = N'COLUMN', @level2name = N'ErrorMensaje';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en que se creó el registro del mensaje emergente.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentes', @level2type = N'COLUMN', @level2name = N'FechaCreacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en que se modificó por última vez el registro del mensaje emergente.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentes', @level2type = N'COLUMN', @level2name = N'FechaModificacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicador del modulo con el que esta relacionado el mensaje emergente.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentes', @level2type = N'COLUMN', @level2name = N'Fk_Metodo';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicador del modulo con el que esta relacionado el mensaje emergente.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentes', @level2type = N'COLUMN', @level2name = N'Fk_Modulo';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicador del tipo de mensaje.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentes', @level2type = N'COLUMN', @level2name = N'Fk_TipoMensaje';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicador del titulo con el que se relacione el mensaje emergente.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentes', @level2type = N'COLUMN', @level2name = N'Fk_Titulo';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Identificador único de tipo entero para el departamento', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentes', @level2type = N'COLUMN', @level2name = N'Id';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Mensaje que se muestra en las mensaje emergentes.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentes', @level2type = N'COLUMN', @level2name = N'Mensaje';
GO
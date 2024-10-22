--============================================================================
-- Nombre del Objeto: tblMensajesEmergentesMetodo.
-- Descripcion:
--		Esta tabla almacena información sobre los metodos de la aplicacion web.
-- Objetivo: 
--		Administrar y almacenar información detallada sobre los metodos que se generan en la aplicacion web.
-- Tipo de Objeto: 
--     Tabla.
-- Motor:
--		MSSQL Server.
-- Origen de los Datos:
--		Datos ingresados por script.
-- Permanencia de Datos:
--		Los datos se almacenan de forma permanente para poder mostrar los mensajes emergentes por cada metodo.
-- Uso de los datos:
--		Los datos se utilizan para visualizar los mensajes emergentes por metodo.
-- Restricciones o consideraciones:
--     - No aplican restricciones.
--	Parametros de Entrada y de Salida:
--     No aplicable (ya que es una tabla y no un procedimiento almacenado).
--============================================================================
CREATE TABLE [dbo].[MensajesEmergentesMetodo] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Metodo]            VARCHAR (50)   NOT NULL,
    [FechaCreacion]     SMALLDATETIME  CONSTRAINT [DF_MensajesEmergentesMetodo_FechaCreacion] DEFAULT (CONVERT([smalldatetime],getdate())) NOT NULL,
    [FechaModificacion] SMALLDATETIME  NULL,
    CONSTRAINT [PK_MensajesEmergentesMetodo] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en que se creó el registro del metodo.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesMetodo', @level2type = N'COLUMN', @level2name = N'FechaCreacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en que se modificó por última vez el registro del metodo.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesMetodo', @level2type = N'COLUMN', @level2name = N'FechaModificacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Identificador único de tipo entero para el metodo', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesMetodo', @level2type = N'COLUMN', @level2name = N'Id';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Nombre que describe la funcion del metodo.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesMetodo', @level2type = N'COLUMN', @level2name = N'Metodo';
GO
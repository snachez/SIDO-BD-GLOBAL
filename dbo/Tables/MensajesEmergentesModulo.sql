--============================================================================
-- Nombre del Objeto: tblMensajesEmergentesModulo.
-- Descripcion:
--		Esta tabla almacena información sobre los metodos de la aplicacion web.
-- Objetivo: 
--		Administrar y almacenar información detallada sobre los modulos de la aplicacion web.
-- Tipo de Objeto: 
--     Tabla.
-- Motor:
--		MSSQL Server.
-- Origen de los Datos:
--		Datos ingresados por script.
-- Permanencia de Datos:
--		Los datos se almacenan de forma permanente para poder mostrar los mensajes emergentes por cada modulo de la aplicacion web.
-- Uso de los datos:
--		Los datos se utilizan para visualizar los mensajes emergentes por modulo.
-- Restricciones o consideraciones:
--     - No aplican restricciones.
--	Parametros de Entrada y de Salida:
--     No aplicable (ya que es una tabla y no un procedimiento almacenado).
--============================================================================


CREATE TABLE [dbo].[MensajesEmergentesModulo] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Modulo]            VARCHAR (50)   NOT NULL,
    [FechaCreacion]     SMALLDATETIME  CONSTRAINT [DF_MensajesEmergentesModulo_FechaCreacion] DEFAULT (CONVERT([smalldatetime],getdate())) NOT NULL,
    [FechaModificacion] SMALLDATETIME  NULL,
    CONSTRAINT [PK_MensajesEmergentesModulo] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en que se creó el registro del modulo.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesModulo', @level2type = N'COLUMN', @level2name = N'FechaCreacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en que se modificó por última vez el registro del modulo.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesModulo', @level2type = N'COLUMN', @level2name = N'FechaModificacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Identificador único de tipo entero para el modulo', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesModulo', @level2type = N'COLUMN', @level2name = N'Id';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Nombre que describe la funcion del modulo.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MensajesEmergentesModulo', @level2type = N'COLUMN', @level2name = N'Modulo';
GO
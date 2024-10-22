--============================================================================
-- Nombre del Objeto: Area.
-- Descripcion:
--		Esta tabla almacena información sobre las areas que tendran acceso al motor
-- Objetivo: 
--		Administrar y almacenar información detallada sobre las areas que tendran acceso al motor
-- Tipo de Objeto: 
--     Tabla.
-- Motor:
--		MSSQL Server.
-- Origen de los Datos:
--		Los datos provienen de una persona que los registra mediante la aplicacion web del motor, del modulo de manteniemiento.
-- Permanencia de Datos:
--		Los datos se almacenan de forma permanente para poder gestionar las areas que tendran acceso al motor
-- Uso de los datos:
--		Los datos se utilizan para gestionar las areas que tendran acceso al moto.
-- Restricciones o consideraciones:
--     - se garantiza que las las areas que tendran acceso al motor no esten repetidas
--	Parametros de Entrada y de Salida:
--     No aplicable (ya que es una tabla y no un procedimiento almacenado).
--============================================================================

CREATE TABLE [dbo].[Area] (
    [Id]                INT          IDENTITY (1, 1) NOT NULL,
    [Nombre]            VARCHAR (50) NOT NULL,
    [Activo]            BIT          CONSTRAINT [DF_Area_Activo] DEFAULT (0) NULL,
    [FechaCreacion]     DATETIME     CONSTRAINT [DF_Area_FechaCreacion] DEFAULT (CONVERT([smalldatetime],getdate())) NULL,
    [FechaModificacion] DATETIME     NULL,
    CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [t2_C1_Unique_Nombre_Area] UNIQUE NONCLUSTERED ([Nombre] ASC)
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Identificador único de tipo entero.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Area', @level2type = N'COLUMN', @level2name = N'Id';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Nombre del area.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Area', @level2type = N'COLUMN', @level2name = N'Nombre';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Idicador de si el registro esta Activo(1) o Inactivo(0).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Area', @level2type = N'COLUMN', @level2name = N'Activo';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en la que se crea el registro.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Area', @level2type = N'COLUMN', @level2name = N'FechaCreacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fecha en la que se modifica el registro.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Area', @level2type = N'COLUMN', @level2name = N'FechaModificacion';
GO
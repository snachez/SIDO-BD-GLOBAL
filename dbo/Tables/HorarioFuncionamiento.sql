--============================================================================
-- Nombre del Objeto: HorarioFuncionamiento.
-- Descripcion:
--		Esta tabla almacena información sobre el horario de funcionamiento del motos
-- Objetivo: 
--		Administrar y almacenar información detallada sobre los dias y horas de funcionamietno del motor
-- Tipo de Objeto: 
--     Tabla.
-- Motor:
--		MSSQL Server.
-- Origen de los Datos:
--		Los datos provienen de una persona que los registra mediante la aplicacion web del motor, del modulo de manteniemiento.
-- Permanencia de Datos:
--		Los datos se almacenan de forma permanente para poder gestionar las horas de funcionamiento del motor
-- Uso de los datos:
--		Los datos se utilizan para gestionar las horas de funcionamiento del motor
-- Restricciones o consideraciones:
--     - se garantiza que las horas de funcionamiento del motor sean acorde a las reglas definidas por negocio
--	Parametros de Entrada y de Salida:
--     No aplicable (ya que es una tabla y no un procedimiento almacenado).
--============================================================================

CREATE TABLE [dbo].[HorarioFuncionamiento] (
    [Id]                INT           IDENTITY (1, 1) NOT NULL,
    [Dia]               INT           NOT NULL,
    [NombreDia]         VARCHAR (9)   NOT NULL,
    [HoraInicio]        TIME (7)      NOT NULL,
    [HoraFinal]         TIME (7)      NOT NULL,
    [FechaCreacion]     DATETIME      CONSTRAINT [DF_HorarioFuncionamiento_FechaCreacion] DEFAULT (CONVERT([smalldatetime],getdate())) NULL,
    [FechaModificacion] DATETIME      NULL,
    [Activo]            BIT           CONSTRAINT [DF_HorarioFuncionamiento_Activo] DEFAULT (0) NULL,
    CONSTRAINT [PK_HorarioFuncionamiento] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_CheckHoraDesdeHastaValido] CHECK ([HoraInicio]<=[HoraFinal]),
    CONSTRAINT [CK_checkHoraHastaDesdeNotNull] CHECK (case when [Activo]=(1) then case when [HoraInicio] IS NOT NULL AND [HoraFinal] IS NOT NULL then (1) else (0) end else (1) end=(1)),
    CONSTRAINT [CK_Dia_Valido] CHECK ([Dia]>=(1) AND [Dia]<=(7))
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Idicador de si el registro esta Activo(1) o Inactivo(0)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HorarioFuncionamiento', @level2type = N'COLUMN', @level2name = N'Activo';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Fecha en la que se crea el registro de tipo Horario de Funcionamiento del motor', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HorarioFuncionamiento', @level2type = N'COLUMN', @level2name = N'FechaCreacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Fecha en la que se modifica el registro de tipo Horario de Funcionamiento del motor', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HorarioFuncionamiento', @level2type = N'COLUMN', @level2name = N'FechaModificacion';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Hora de cierre para el motor en el dia establecido', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HorarioFuncionamiento', @level2type = N'COLUMN', @level2name = N'HoraFinal';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Hora de inicio para el motor en el dia establecido', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HorarioFuncionamiento', @level2type = N'COLUMN', @level2name = N'HoraInicio';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Nombre del dia de la semana para definir le horario de funcionamieto', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'HorarioFuncionamiento', @level2type = N'COLUMN', @level2name = N'NombreDia';
GO
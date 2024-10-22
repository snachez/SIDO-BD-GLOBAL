CREATE PROCEDURE [dbo].[usp_Select_MensajesEmergentes]
(
    @Modulo NVARCHAR(MAX) = NULL,
    @Metodo NVARCHAR(MAX) = NULL,
	@TipoMensaje NVARCHAR(MAX) = NULL,
	@Titulo NVARCHAR(MAX) = NULL,
	@Mensaje NVARCHAR(MAX) = NULL,
	@ErrorMensaje NVARCHAR(MAX) = NULL,
    @TituloSalida NVARCHAR(MAX) OUTPUT,
    @MensajeSalida NVARCHAR(MAX) OUTPUT
)
AS
BEGIN

	SELECT
	  @TituloSalida = T.Titulo,
	  @MensajeSalida = ME.Mensaje
	FROM MensajesEmergentes ME
	INNER JOIN MensajesEmergentesMetodo MET
	  ON ME.Fk_Metodo = MET.Id
	INNER JOIN MensajesEmergentesModulo MO
	  ON ME.Fk_Modulo = MO.Id
	INNER JOIN MensajesEmergentesTipo TM
	  ON ME.Fk_TipoMensaje = TM.Id
	INNER JOIN MensajesEmergentesTitulo T
	  ON ME.Fk_Titulo = T.Id
	WHERE 
	(
		MET.Metodo = ISNULL(@Metodo, MET.Metodo)
		AND TM.TipoMensaje = ISNULL(@TipoMensaje, TM.TipoMensaje)
		AND T.Titulo = ISNULL(@Titulo, T.Titulo)
		AND ME.Mensaje = ISNULL(@Mensaje, ME.Mensaje)
		AND MO.Modulo = ISNULL(@Modulo, MO.Modulo)
	)
	AND 
	(
		ME.ErrorMensaje = ISNULL(@ErrorMensaje, ME.ErrorMensaje)
		OR ME.ErrorMensaje IS NULL
	);

END;
CREATE PROCEDURE [dbo].[usp_Select_MensajesEmergentes_Para_SP]
(
    @ROWS_AFFECTED INT = 0,
    @SUCCESS BIT = 0,
    @ERROR_NUMBER_SP INT = 0,
    @CONSTRAINT_TRIGGER_NAME NVARCHAR(MAX) = NULL, 
    @ID INT = 0,
    @ROW NVARCHAR(MAX) = NULL,
    @Modulo NVARCHAR(MAX) = NULL,
    @Metodo NVARCHAR(MAX) = NULL,
    @TipoMensaje NVARCHAR(MAX) = NULL,
    @ErrorMensaje NVARCHAR(MAX) = NULL,
    @ModeJson BIT = 0
)
AS
BEGIN
    -- Procesamiento de @CONSTRAINT_TRIGGER_NAME
    DECLARE @SingleQuoteIndex INT = CHARINDEX('''', @CONSTRAINT_TRIGGER_NAME);
    DECLARE @DoubleQuoteIndex INT = CHARINDEX('"', @CONSTRAINT_TRIGGER_NAME);

    DECLARE @StartIndex INT;

    IF @SingleQuoteIndex > 0 AND @DoubleQuoteIndex > 0
    BEGIN
        SET @StartIndex = CASE 
                            WHEN @SingleQuoteIndex < @DoubleQuoteIndex 
                            THEN @SingleQuoteIndex 
                            ELSE @DoubleQuoteIndex 
                          END;
    END
    ELSE IF @SingleQuoteIndex > 0
    BEGIN
        SET @StartIndex = @SingleQuoteIndex;
    END
    ELSE 
    BEGIN
        SET @StartIndex = @DoubleQuoteIndex;
    END


    DECLARE @EndIndex INT = CHARINDEX(IIF(@StartIndex = @SingleQuoteIndex, '''', '"'), @CONSTRAINT_TRIGGER_NAME, @StartIndex + 1);
    DECLARE @CONSTRAINT NVARCHAR(MAX) = IIF(@StartIndex > 0 AND @EndIndex > 0, 
        SUBSTRING(@CONSTRAINT_TRIGGER_NAME, @StartIndex + 1, @EndIndex - @StartIndex - 1),
        @CONSTRAINT_TRIGGER_NAME);

    -- Procesamiento de @ErrorMensaje
    DECLARE @SoloQuoteIndex INT = CHARINDEX('''', @ErrorMensaje);
    DECLARE @DobleQuoteIndex INT = CHARINDEX('"', @ErrorMensaje);

    DECLARE @InicioIndex INT;

    IF @SoloQuoteIndex > 0 AND @DobleQuoteIndex > 0
    BEGIN
        SET @InicioIndex = CASE 
                            WHEN @SoloQuoteIndex < @DobleQuoteIndex 
                            THEN @SoloQuoteIndex 
                            ELSE @DobleQuoteIndex 
                          END;
    END
    ELSE IF @SoloQuoteIndex > 0
    BEGIN
        SET @InicioIndex = @SoloQuoteIndex;
    END
    ELSE 
    BEGIN
        SET @InicioIndex = @DobleQuoteIndex;
    END


    DECLARE @FinalIndex INT = CHARINDEX(IIF(@InicioIndex = @SoloQuoteIndex, '''', '"'), @ErrorMensaje, @InicioIndex + 1);
    DECLARE @ErrorSinClave NVARCHAR(MAX) = IIF(@InicioIndex > 0 AND @FinalIndex > 0, 
        SUBSTRING(@ErrorMensaje, @InicioIndex + 1, @FinalIndex - @InicioIndex - 1),
        @ErrorMensaje);

    -- Selección de mensajes emergentes
    DECLARE @SQL NVARCHAR(MAX) = '
        SELECT TOP 1 @ROWS_AFFECTED AS ROWS_AFFECTED, 
                     @SUCCESS AS SUCCESS, 
                     T.Titulo AS ERROR_TITLE_SP, 
                     ME.Mensaje AS ERROR_MESSAGE_SP, 
                     @ERROR_NUMBER_SP AS ERROR_NUMBER_SP,
                     @CONSTRAINT AS CONSTRAINT_TRIGGER_NAME, 
                     @ID AS ID, 
                     @ROW AS ROW
        FROM MensajesEmergentes ME
        INNER JOIN MensajesEmergentesMetodo MET ON ME.Fk_Metodo = MET.Id
        INNER JOIN MensajesEmergentesModulo MO ON ME.Fk_Modulo = MO.Id
        INNER JOIN MensajesEmergentesTipo TM ON ME.Fk_TipoMensaje = TM.Id
        INNER JOIN MensajesEmergentesTitulo T ON ME.Fk_Titulo = T.Id
        WHERE (MET.Metodo = ISNULL(@Metodo, MET.Metodo)
           AND TM.TipoMensaje = ISNULL(@TipoMensaje, TM.TipoMensaje)
           AND MO.Modulo = ISNULL(@Modulo, MO.Modulo))
          AND (ME.ErrorMensaje = ISNULL(@ErrorSinClave, ME.ErrorMensaje)
           OR ME.ErrorMensaje IS NULL)';

    IF @ModeJson = 1
    BEGIN
        SET @SQL = @SQL + ' FOR JSON PATH, INCLUDE_NULL_VALUES';
    END

    -- Ejecución dinámica
    EXEC sp_executesql @SQL, 
        N'@ROWS_AFFECTED INT, @SUCCESS BIT, @ERROR_NUMBER_SP INT, @CONSTRAINT NVARCHAR(MAX), @ID INT, @ROW NVARCHAR(MAX), @Metodo NVARCHAR(MAX), @TipoMensaje NVARCHAR(MAX), @Modulo NVARCHAR(MAX), @ErrorSinClave NVARCHAR(MAX)',
        @ROWS_AFFECTED, @SUCCESS, @ERROR_NUMBER_SP, @CONSTRAINT, @ID, @ROW, @Metodo, @TipoMensaje, @Modulo, @ErrorSinClave;
END;

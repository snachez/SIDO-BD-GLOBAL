--
CREATE   PROCEDURE [dbo].[usp_SelectArea]  (	  @ID						INT				=	NULL
											, @NOMBRE					VARCHAR(MAX)	=	NULL                                            
											, @SEARCHING				VARCHAR(MAX)	=	NULL											
											, @ACTIVO					BIT				=	NULL
											, @PAGE						INT				=	1
											, @SIZE						INT				=	10
											, @FILTROS_SITES_JSON		VARCHAR(MAX)	=	NULL
											, @ORDER_BY					INT				=	1
											--, @USUARIO_ID				INT				=	NULL
										)
AS
BEGIN
	---
	SET @PAGE = ISNULL(@PAGE, 1)
	SET @SIZE = ISNULL(@SIZE, 10)
	SET @NOMBRE = ISNULL(@NOMBRE, '')
	SET @FILTROS_SITES_JSON = ISNULL(@FILTROS_SITES_JSON, '')
	----------------------------------------------------------------------------------------
	--- V A R I A B L E S		F O R M A T E O		F E C H A . . .
	----------------------------------------------------------------------------------------

	----------------------------------------------------------------------------------------
	DECLARE @TOTAL_RECORDS INT = 0



	---	FULL DATA ...
	SELECT     A.Id							AS [Id]
			, A.Nombre						AS [Nombre]	
			, A.Activo						AS [Activo]
			, A.FechaCreacion				AS [FechaCreacion]
			, A.FechaModificacion			AS [FechaModificacion]
		INTO #tblFullData
		FROM Area A

	---
	
	
	SELECT * INTO #tblDataFiltrada FROM #tblFullData 
	WHERE
	Nombre LIKE CONCAT('%', ISNULL(@SEARCHING, Nombre), '%')		
		OR Id LIKE CONCAT('%', ISNULL(@SEARCHING, Id), '%')
	


	DECLARE @JSON_RESULT NVARCHAR(MAX)


	------------------------------------------
	--		DATA INDEXADA & FILTRADA . . .
	------------------------------------------
	;WITH DATA_INDEXED AS (				SELECT	  *
												, CASE 
														WHEN @ORDER_BY = -1 THEN ROW_NUMBER() OVER(ORDER BY Id DESC)
														WHEN @ORDER_BY =  1 THEN ROW_NUMBER() OVER(ORDER BY Id)

														WHEN @ORDER_BY = -2 THEN ROW_NUMBER() OVER(ORDER BY Activo DESC)
														WHEN @ORDER_BY =  2 THEN ROW_NUMBER() OVER(ORDER BY Activo)

														WHEN @ORDER_BY = -3 THEN ROW_NUMBER() OVER(ORDER BY Nombre DESC)
														WHEN @ORDER_BY =  3 THEN ROW_NUMBER() OVER(ORDER BY Nombre)

														ELSE ROW_NUMBER() OVER(ORDER BY Id)
														END
												AS [INDEX]
										FROM #tblDataFiltrada
										WHERE Id = ISNULL(@ID, Id)							
										AND Activo = ISNULL(@ACTIVO, Activo)								
									)

	
	SELECT * INTO #tmpTblDataIndexed FROM DATA_INDEXED ORDER BY [INDEX]
	--

	--- TOTAL DE FILAS SIN PAGINAR
	SET @TOTAL_RECORDS = (SELECT COUNT(*) FROM #tmpTblDataIndexed)


	---
	SET @JSON_RESULT = (SELECT * FROM #tmpTblDataIndexed WHERE [INDEX] BETWEEN ((@PAGE * @SIZE)-(@SIZE-1)) AND (@PAGE * @SIZE) ORDER BY [INDEX] FOR JSON PATH) -- PAGINAR... ORDER BY [INDEX] FOR JSON PATH)
	SELECT @JSON_RESULT AS JSON_RESULT_SELECT--


	DROP TABLE #tmpTblDataIndexed
	

	---	 LIMPIAR SEARCHING ...
	SET @SEARCHING = IIF(@SEARCHING IS NOT NULL, REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(@SEARCHING), CHAR(13), ''), CHAR(10), ''), CHAR(9), ''), CHAR(11), ''), NULL)
	SET @SEARCHING = IIF(@SEARCHING IS NOT NULL AND @SEARCHING <> '', CONCAT('%', @SEARCHING, '%'), NULL)
	---

	DROP TABLE #tblFullData
	---
END
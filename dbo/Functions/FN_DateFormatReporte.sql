
CREATE   FUNCTION FN_DateFormatReporte(@DATE DATETIME)
RETURNS VARCHAR(MAX)
AS
BEGIN
	---
	DECLARE @RESULT VARCHAR(MAX) = (
	
		CASE 	WHEN @DATE IS NOT NULL AND @DATE <> ''
				THEN STUFF( (
								SELECT

								--espanol
									', ' +  (FORMAT(@DATE, 'dd/MM/yyyy'))										--19/12/2023
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy hh:mm'))									--19/12/2023 10:10
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy hh:mm:ss'))								--19/12/2023 10:10:00
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy hh:mm:ss tt'))							--19/12/2023 18:03:00 PM o AM
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy hh:mm:sstt'))							--19/12/2023 18:03:00PMoAM					
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy hh:mm tt'))								--19/12/2023 18:03 PM o AM
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy hh:mmtt'))								--19/12/2023 18:03PMoAM																 
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyhh:mm:ss'))								--19/12/202318:03:00						
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyhh:mm'))									--19/12/202318:03							
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyhh:mmtt'))								--19/12/202318:03PMoAM						
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyhh:mm:sstt'))								--19/12/202318:03:00PMoAM					
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyhh:mm:ss tt'))							--19/12/202318:03:00 PMoAM					
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyhh:mm tt'))								--19/12/202318:03 PMoAM						

								  --militar
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy HH:mm'))									--19/12/2023 10:10
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy HH:mm:ss'))								--19/12/2023 10:10:00
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy HH:mm:ss tt'))							--19/12/2023 18:03:00 PM o AM
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy HH:mm:sstt'))							--19/12/2023 18:03:00PMoAM					
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy HH:mm tt'))								--19/12/2023 18:03 PM o AM
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyy HH:mmtt'))								--19/12/2023 18:03PMoAM																 
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyHH:mm:ss'))								--19/12/202318:03:00						
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyHH:mm'))									--19/12/202318:03							
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyHH:mmtt'))								--19/12/202318:03PMoAM						
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyHH:mm:sstt'))								--19/12/202318:03:00PMoAM					
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyHH:mm:ss tt'))							--19/12/202318:03:00 PMoAM					
								  + ', ' +  (FORMAT(@DATE, 'dd/MM/yyyyHH:mm tt'))								--19/12/202318:03 PMoAM						

								  --espanol
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy'))									    --19-12-2023
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy hh:mm'))									--19-12-2023 18:03
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy hh:mm:ss'))								--19-12-2023 18:03:00
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy hh:mm:ss tt'))							--19-12-2023 18:03:00 PM o AM	 
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy hh:mm:sstt'))							--19-12-2023 18:03:00PMoAM					 
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy hh:mm tt'))								--19-12-2023 18:03 PM o AM
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy hh:mmtt'))								--19-12-2023 18:03PMoAM						
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyhh:mm:ss'))								--19-12-202318:03:00						
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyhh:mm'))								    --19-12-202318:03							
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyhh:mmtt'))								--19-12-202318:03PMoAM						 
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyhh:mm:sstt'))								--19-12-202318:03:00PMoAM					
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyhh:mm:ss tt'))							--19-12-202318:03:00 PMoAM					
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyhh:mm tt'))								--19-12-202318:03:00 PMoAM						
								  --militar
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy HH:mm'))									--19-12-2023 18:03
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy HH:mm:ss'))								--19-12-2023 18:03:00
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy HH:mm:ss tt'))							--19-12-2023 18:03:00 PM o AM	 
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy HH:mm:sstt'))							--19-12-2023 18:03:00PMoAM					 
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy HH:mm tt'))								--19-12-2023 18:03 PM o AM
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyy HH:mmtt'))								--19-12-2023 18:03PMoAM						
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyHH:mm:ss'))								--19-12-202318:03:00						
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyHH:mm'))								    --19-12-202318:03							
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyHH:mmtt'))								--19-12-202318:03PMoAM						 
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyHH:mm:sstt'))								--19-12-202318:03:00PMoAM					
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyHH:mm:ss tt'))							--19-12-202318:03:00 PMoAM					
								  + ', ' +  (FORMAT(@DATE, 'dd-MM-yyyyHH:mm tt'))								--19-12-202318:03:00 PMoAM					
								FOR XML PATH ('')), 1, 2, '')
							 ELSE 'N/D' END)
	--
	RETURN @RESULT
	--
END
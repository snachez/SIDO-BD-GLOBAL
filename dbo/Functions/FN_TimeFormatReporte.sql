
CREATE   FUNCTION FN_TimeFormatReporte(@DATE DATETIME)
RETURNS VARCHAR(MAX)
AS
BEGIN
	---
	DECLARE @RESULT VARCHAR(MAX) = (
	
		CASE 	WHEN @DATE IS NOT NULL AND @DATE <> ''
				THEN STUFF(
				(
					SELECT
								', ' +  (FORMAT(@DATE, 'hh:mm:ss'))					--18:03:00										 
							  + ', ' +  (FORMAT(@DATE, 'hh:mm:ss tt'))				--18:03:00 PM o AM
							  + ', ' +  (FORMAT(@DATE, 'hh:mm'))					--18:03
							  + ', ' +  (FORMAT(@DATE, 'hh:mm tt'))					--18:03 PM o AM
							  + ', ' +  (FORMAT(@DATE, 'hh:mm:sstt'))				--18:03:00PMoAM      
							  + ', ' +  (FORMAT(@DATE, 'hh:mmtt'))					--18:03PMoAM	     
																										 -- toma la hora tal cual como se guarda pero en militar mas AM O PM
							  + ', ' +  (FORMAT(@DATE, 'HH:mm:ss'))					--18:03:00		     
							  + ', ' +  (FORMAT(@DATE, 'HH:mm:ss tt'))				--18:03:00	PM o AM	 
							  + ', ' +  (FORMAT(@DATE, 'HH:mm'))					--18:03
							  + ', ' +  (FORMAT(@DATE, 'HH:mm tt'))					--18:03 PM o AM
							  + ', ' +  (FORMAT(@DATE, 'HH:mm:sstt'))				--18:03:00PMoAM      
							  + ', ' +  (FORMAT(@DATE, 'HH:mmtt'))					--18:03PMoAM	     
							FOR XML PATH ('')
				), 1, 2, '') 
				ELSE 'N/D' END)
	--
	RETURN @RESULT
	--
END
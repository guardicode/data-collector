@echo off
setlocal EnableDelayedExpansion

	if not exist results (mkdir results)
    set /p defaultuser="Enter an Administrator username: "
    set /p defaultpass="Enter password: "
	for /F "tokens=1-3 delims=," %%i in (windows_machines.ini) do (
	   set ip=%%i
	   if %%j==default (set username=!defaultuser!) else (set username=%%j)
	   if %%k==default (set passwd=!defaultpass!) else (set passwd=%%k)
       PSexec.exe \\!ip! -u !username! -p !passwd! -c collect_data_from_windows_machines.bat > results\output-!ip!.txt
	)
	if exist "C:\Program Files\7-Zip\7z.exe" (
		"C:\Program Files\7-Zip\7z.exe" a -tzip results.zip -r results
	) else (
		echo 7zip not in default path C:\Program Files\7-Zip\7z.exe
	)

endlocal
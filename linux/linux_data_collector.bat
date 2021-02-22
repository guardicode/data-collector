@echo off
setlocal EnableDelayedExpansion

	if not exist results (mkdir results)
    set /p defaultuser="Enter an Administrator username: "
    set /p defaultpass="Enter password: "
	for /F "tokens=1-3 delims=," %%i in (linux_machines.ini) do (
	   set ip=%%i
	   if %%j==default (set username=!defaultuser!) else (set username=%%j)
	   if %%k==default (set passwd=!defaultpass!) else (set passwd=%%k)
       putty.exe !username!@!ip! -pw !passwd! -m collect_data_from_linux_machines.sh
	   pscp.exe -pw !passwd! !username!@!ip!:/tmp/gc-data-collection/results/* %cd%\results
	)
	if exist "C:\Program Files\7-Zip\7z.exe" (
		"C:\Program Files\7-Zip\7z.exe" a -tzip results.zip -r results
	) else (
		echo 7zip not in default path C:\Program Files\7-Zip\7z.exe
	)

endlocal

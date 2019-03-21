@ECHO OFF
rem DYNAMIC DIRECTORY (you can set these fixed if you want)
set "source_folder=%CD%"
set "destination_folder_1=%source_folder%\Resized"
set "destination_original=%source_folder%\Backup"
echo ______________________________________________________
echo PICRESIZE v1.1.
echo RESIZE .JPG TO 1920 X 1280.
echo https://github.com/skjolddesign/picresize
echo ______________________________________________________
echo Usage: 
echo Make Windows Shortcut. 
echo 'Start in' parameter sets Source folder.
echo If 'Start in' is blank, it will use folder started from.
echo If argument -delete is added to 'Target' parameter, Source will be deleted.
echo If argument -delete is not added, Source will be moved to Backup folder.
echo ______________________________________________________
echo SOURCE:      %source_folder%
echo DESTINATION: %destination_folder_1%


rem user added '-delete' argument
if "%1"=="-delete" (
	echo Notice! Delete source image selected.
)ELSE (
	REM MAKE DESTINATION DIR
	if not exist "%destination_original%" mkdir "%destination_original%
	echo BACKUP:      %destination_original%
)




REM CHECK DEPENDENCY
if not exist "%~dp0scale.bat" GOTO SKIP04
 
REM MAKE DESTINATION DIR
if not exist "%destination_folder_1%" mkdir "%destination_folder_1%"

goto :answeryes


:LOOP    
PING 1.1.1.1 -n 2 -w 1000 >NUL
IF NOT EXIST "%source_folder%\*jpg" GOTO SKIP01
REM All this gets done if the file exists...
if not exist "%destination_folder_1%" GOTO SKIP02
REM ALL THIS GETS DONE IF FOLDER EXISTS

REM DOWNSIZE
for %%a in ("%source_folder%\*jpg") do (
   call %~dp0scale.bat -source "%%a" -target "%destination_folder_1%\%%~nxa" -max-height 1280 -max-width 1920 -keep-ratio yes -force yes
   IF ERRORLEVEL 1 GOTO SKIP03
	rem copy if delete not selected
	IF "%~1"=="-d" (
		rem echo delete
		) ELSE (
		xcopy "%%a" "%destination_original%" /q /y
		)
	del "%%a"
	echo Resized %%a

)

)
echo Ready
PING 1.1.1.1 -n 5 -w 1000 >NUL




:
:
:SKIP01
rem echo no jpg found %source_folder%
PING 1.1.1.1 -n 5 -w 1000 >NUL
GOTO LOOP

:
:
:SKIP02
echo Destination folder not found
PING 1.1.1.1 -n 10 -w 1000 >NUL
GOTO LOOP

:
:
:SKIP03
echo Resize error
PING 1.1.1.1 -n 10 -w 1000 >NUL
GOTO LOOP

:
:
:SKIP04
echo Missing dependency file scale.bat
pause
exit

:answeryes
echo ______________________________________________________
echo Ready for image in Source
GOTO LOOP

:answerno
echo Exiting..
pause
exit

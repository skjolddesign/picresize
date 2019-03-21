@ECHO OFF
rem FIXED DIRECTORY
rem set "source_folder=f:\downloads\img"
rem set "destination_folder_1=f:\downloads\img\Auto-resized"

rem DYNAMIC DIRECTORY
set "source_folder=%CD%"
set "destination_folder_1=%CD%\resized"

echo Picresize.
echo Resize all jpg pictures in folder to 1920 X 1280.
echo TIP: SET SOURCE DIRECTORY WITH WINDOWS SHORTCUT 'START IN' PARAMETER.
echo SOURCE:      %source_folder%
echo DESTINATION: %destination_folder_1%
echo *******************************************
echo WARNING, SOURCE IMAGES WILL BE DELETED!
echo RESIZED IMAGES WILL BE FOUND IN resized FOLDER.
echo USE THIS SOFTWARE AT YOUR OWN RISK
echo *******************************************

REM dir test
rem echo dir test
rem echo %CD%
rem echo %~dp0
rem Echo %0
rem echo %~f0

REM CHECK DEPENDENCY
if not exist "%~dp0scale.bat" GOTO SKIP04
 
REM MAKE DESTINATION DIR
if not exist "%destination_folder_1%" mkdir "%destination_folder_1%"



REM Following Choice can be commented out if you want to run this script without intervention.
:choice
set /P c=Are you sure you want to continue[Y/N]?
if /I "%c%" EQU "Y" goto :answeryes
if /I "%c%" EQU "N" goto :answerno
goto :choice



:LOOP    
IF NOT EXIST "%source_folder%\*jpg" GOTO SKIP01
REM All this gets done if the file exists...
if not exist "%destination_folder_1%" GOTO SKIP02
REM ALL THIS GETS DONE IF FOLDER EXISTS

REM DOWNSIZE
for %%a in ("%source_folder%\*jpg") do (
   REM call scale.bat -source "%%~fa" -target "%destination_folder_1%\%%~nxa" -max-height 1280 -max-width 1920 -keep-ratio yes -force yes
   call "%~dp0scale.bat" -source "%%~fa" -target "%destination_folder_1%\%%~nxa" -max-height 1280 -max-width 1920 -keep-ratio yes -force yes
   IF ERRORLEVEL 1 GOTO SKIP03
   del "%%a"
   echo Resized %%a
   
)
echo Ready
PING 1.1.1.1 -n 10 -w 1000 >NUL




:
:
:SKIP01
rem echo no jpg found %source_folder%
PING 1.1.1.1 -n 10 -w 1000 >NUL
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
echo Ready for you to place images in Source
GOTO LOOP

:answerno
echo Exiting..
pause
exit

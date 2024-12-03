@echo off
title BATos
:startup
cls
echo Initializing...
:: Search for BTSEC binary
set "btsec_found=0"
for /r "%cd%" %%f in (BTSEC.bin) do (
    set "btsec_path=%%f"
    set "btsec_found=1"
    goto btsec_check
)

:btsec_check
if "%btsec_found%"=="1" (
    echo BTSEC binary found: %btsec_path%
    echo Booting BTSEC...
    start "" "%btsec_path%"
    echo BTSEC binary loaded successfully.
) else (
    echo BTSEC binary not found.
    echo Creating a new BTSEC binary: bootsector.bin...
    call :create_btsec
)

pause
goto terminal

:create_btsec
:: Create a new BTSEC.bin (bootsector.bin)
echo This is a placeholder bootsector binary created by BATos.> "bootsector.bin"
set "btsec_path=%cd%\bootsector.bin"
set "btsec_found=1"
echo BTSEC binary created successfully at %btsec_path%.
exit /b

:terminal
cls
echo BATos ver 0.5 Alpha.
echo Type Help for list of commands.
:command_loop
set /p "input=BTSEC.bin\operator> "
if /i "%input%"=="exit" goto shutdown
if /i "%input%"=="help" goto help
if /i "%input%"=="explorer" goto explorer
if /i "%input%"=="sysinfo" goto sysinfo
if /i "%input%"=="runbtsec" goto run_btsec
if /i "%input%"=="clear" goto clear_screen
if /i "%input%"=="search" goto search
if /i "%input%"=="diskspace" goto diskspace
if /i "%input%"=="run:goober.com" goto secret

:: Handle invalid command
echo '%input%' is not recognized as a command. Type 'help' for a list of commands.
goto command_loop

:clear_screen
cls
goto terminal

:help
echo =======================================
echo List of Commands:
echo help       - Display this help message
echo explorer   - Open File Explorer
echo sysinfo    - Display system information
echo runbtsec   - Run the BTSEC binary (if available)
echo clear      - Clear the terminal screen
echo search     - Search for files by name
echo diskspace  - Display disk space usage
echo exit       - Exit BTSEC OS
echo =======================================
pause
goto command_loop

:explorer
cls
echo =======================================
echo             BATos File Explorer
echo =======================================
:explorer_menu
echo Current Directory: %cd%
dir /b
echo =======================================
echo Enter a file or directory name:
echo (Type ".." to go up a directory, "create" to make a new file, or "back" to exit the explorer)
set /p "file_input=Explorer> "

if /i "%file_input%"=="back" goto command_loop
if /i "%file_input%"==".." (
    cd ..
    goto explorer_menu
)
if /i "%file_input%"=="create" (
    call :create_file
    goto explorer_menu
)

if exist "%file_input%" (
    if exist "%file_input%\*" (
        cd "%file_input%"
        goto explorer_menu
    ) else (
        call :view_file "%file_input%"
    )
) else (
    echo '%file_input%' does not exist.
    pause
    goto explorer_menu
)

:create_file
:: Prompt the user to create a new file
cls
echo =======================================
echo             Create New File
echo =======================================
set /p "new_file=Enter file name (with extension): "
:: Ensure the file name is not empty and avoid directory issues
if "%new_file%"=="" (
    echo Invalid file name.
    pause
    exit /b
)

:: Check if the file exists already
if exist "%new_file%" (
    echo File '%new_file%' already exists.
    pause
    exit /b
)

:: Check if the file is a text-based file for content input
for %%x in (.txt .log .bat .json .xml .csv .html) do (
    if /i "%new_file:~-4%"=="%%x" (
        echo Enter the content for '%new_file%' (type EOF to finish):
        echo. > "%new_file%"
        :input_loop
        set /p "line=>> "
        if /i "%line%"=="EOF" goto file_created
        echo %line%>> "%new_file%"
        goto input_loop
    )
)

:: Create an empty file for unsupported types
echo File '%new_file%' created successfully as an empty file.
type nul > "%new_file%"

:file_created
echo File '%new_file%' created successfully.
pause
exit /b

:view_file
:: Display the content of a file in the terminal
cls
set "file=%~1"
for %%x in (.txt .log .json .xml .csv .html) do (
    if /i "%file:~-4%"=="%%x" (
        echo =======================================
        echo Contents of %file%:
        echo =======================================
        type "%file%"
        echo =======================================
        pause
        goto explorer_menu
    )
)
echo Unsupported file type: %file%
pause
goto explorer_menu

:sysinfo
echo =======================================
echo System Information:
echo Username: %username%
echo Computer Name: %computername%
echo OS Version: %os%
echo Current Directory: %cd%
echo =======================================
pause
goto command_loop

:run_btsec
if "%btsec_found%"=="1" (
    echo Running BTSEC binary from %btsec_path%...
    start "" "%btsec_path%"
) else (
    echo BTSEC binary not found. Please ensure it is in the system directory.
)
pause
goto command_loop

:shutdown
echo Shutting down BATos...
pause
exit

:search
cls
echo =======================================
echo             Search for Files
echo =======================================
echo Enter search keyword (e.g., partial filename):
set /p "search_query=Search> "

echo Searching for files with the keyword: %search_query%
echo =======================================
:: Search for files by the keyword
for /r %%f in (*%search_query%*) do (
    echo Found: %%f
)
echo =======================================
pause
goto command_loop

:diskspace
cls
echo =======================================
echo             Disk Space Usage
echo =======================================
:: Get disk space usage
for /f "tokens=3" %%a in ('dir %cd% ^| findstr "bytes free"') do set "free_space=%%a"
for /f "tokens=3" %%b in ('dir %cd% ^| findstr "bytes" ^| findstr /v "free"') do set "used_space=%%b"

echo Free space: %free_space%
echo Used space: %used_space%
echo =======================================
pause
goto command_loop

:secret
cls
echo CE(JCOsoe9dioF*ofgsDIJfdSOIYIfdioUSDoigoisorryoSDHOIfHheKOSVoD_--G_dudJKDSJKIgJSSoOFjJOSFJOjfJSoDJJOJFOSJOGjD
echo cEJOIfsofeosofgedljgosdog\s\ r\ gsdf\\g\fs\\\ GFIOsoiougiuoisoiuiouoiuoiuiuouoiuoiuoijo8icj9840j990vk4s90f94w
echo foisjoidsjo0sjojfofjdjdffjo9s90390-0kf-023i0290f8wr9f0w3ucvjsojzgrwrfh\s\fes/fx/sfvdsgofhuessh9e98h98h98hfhge
echo fdsjjiesijsoeoijefsjfepp0fjse0jfs0jfesejfjef9s8448h2jh-w040h02f0f48uuw4040uwutf00u440ufu0f4wf0uyfwu0u0wf90u9f
echo sjdoioihferfjosoiefhoijerfiojsfoifrsogsdgdoiuOOOOOOOkdogjoijioojiroijoijojigijrdj9jio9hjioijiojioijijujiojioo
echo jrsoijgoihsoijoijjioiojoihjijojiordojigfshOOOOOOOOOOOOOOOhthtdfgftukigi8hoolnjuoijho87hf9weHa9h9h9hhugeuuhius
echo oisgoidogidsjijogsdojigogsdogosjsgojgdfOOOOOOOOOOOOOOOOOOOOOhgfclhfiijolohjuoiuhugyyrfyrfrytftrf7rdfytyjuhyjh
echo sgfoo8ghpgpouhophuphouhuohppohpohOOOOOOOOOOOOOOOOOOOOOOOOOOOOOhfddfhhiyuhiohuyohohohyi9hhggyouigyhuioawduoifo
echo vjpisgjp[igjirp88php8o0ouppojiojsijojoiOOOOOOOOOOOOOOOOOOOOfdhiusihogiohoihihihfdsssssssssssssssssssssssssssg
timeout /t 0.2 >nul 
echo  CE(JCOsoe9dioF*ofgsDIJfdSOIYIfdioUSDoigoisorryoSDHOIfHheKOSVoD_--G_dudJKDSJKIgJSSoOFjJOSFJOjfJSoDJJOJFOSJOGjD
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
setlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbssetlocal enabledelayedexpansion

:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
echo Initializing...
goto bootloop

:bootloop
echo Initializing...
:: Generate random X and Y positions for the dialog box
set /a "x=%random% %% 1000"
set /a "y=%random% %% 500"

:: Create a VBS script to show the dialog box at the random position
echo Set objShell = CreateObject("WScript.Shell") > temp.vbs
echo objShell.Popup "GO AWAY", 5, "sys:%username%\die", 64 >> temp.vbs
echo Set objShell = Nothing >> temp.vbs

:: Run the VBS script to show the dialog box
start "" wscript temp.vbs

:: Delete the temporary VBS script
del temp.vbs
goto :bootloop
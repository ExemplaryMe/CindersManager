@echo off
setlocal enabledelayedexpansion

rem Get the current path
set "current_path=%cd%"

rem Define required folders
set "game_folder=%current_path%\Game"
set "mods_folder=%current_path%\Mods"
set "saves_folder=%current_path%\Saves"
set "cinders_folder=%mods_folder%\Cinders"
set "active_save=%appdata%\DarkSoulsIII"

rem Check if required folders exist
if not exist "%game_folder%" (
    echo The 'Game' folder does not exist. Exiting.
    exit /b
)

if not exist "%mods_folder%" (
    echo The 'Mods' folder does not exist. Exiting.
    exit /b
)

if not exist "%saves_folder%" (
    echo The 'Saves' folder does not exist. Exiting.
    exit /b
)

if not exist "%cinders_folder%" (
    echo The 'Cinders' folder does not exist in Mods. Exiting.
    exit /b
)

rem Define required mod files
set "mod_files=dinput8.dll HoodiePatcher.dll HoodiePatcher.ini modengine.ini"

:loop
rem Check mod status
set "mod_status=Disabled"
if exist "%game_folder%\dinput8.dll" (
    set "mod_status=Enabled"
)

rem Check for DarkSoulsIII.exe and get file size
set "ds3_exe_path=%game_folder%\DarkSoulsIII.exe"
set "game_version=Unknown"
if exist "%ds3_exe_path%" (
    for %%I in ("%ds3_exe_path%") do set "ds3_exe_size=%%~zI"
    
    rem Determine game version based on file size
    if "!ds3_exe_size!"=="102494368" (
        set "game_version=1.15"
    ) else if "!ds3_exe_size!"=="88960032" (
        set "game_version=1.15.2"
    )
) else (
    set "ds3_exe_size=File not found"
)

rem Define ActiveGamePath
set "ActiveGamePath=%ds3_exe_path%"

rem Display current mod status, file size, game version, ActiveSave path, and ActiveGamePath
echo.
echo ================================
echo Current Mod Status: !mod_status!
echo DarkSoulsIII.exe Size: !ds3_exe_size! bytes
echo Game Version: !game_version!
echo ActiveSave Path: %active_save%
echo ActiveGamePath: !ActiveGamePath!

rem Output folders inside ActiveSave
echo Current folders in ActiveSave:
dir "%active_save%" /ad
echo ================================

rem Check if the ActiveSave folder matches Clean or Cinders
set "active_folder="
for /d %%D in ("%active_save%\*") do (
    set "active_folder=%%~nxD"
)

set "clean_save_folder="
for /d %%D in ("%saves_folder%\Clean\*") do (
    set "clean_save_folder=%%~nxD"
)

set "cinders_save_folder="
for /d %%D in ("%saves_folder%\Cinders\*") do (
    set "cinders_save_folder=%%~nxD"
)

echo Checking if ActiveSave matches Clean or Cinders...
if "!active_folder!"=="" (
    echo No folder found in ActiveSave.
) else (
    echo ActiveSave folder: !active_folder!
    if "!active_folder!"=="!clean_save_folder!" (
        echo ActiveSave matches the Clean Save folder: !clean_save_folder!
    ) else if "!active_folder!"=="!cinders_save_folder!" (
        echo ActiveSave matches the Cinders Save folder: !cinders_save_folder!
    ) else (
        echo ActiveSave does not match any known save folder.
    )
)

rem Display account switching messages
if "!mod_status!"=="Enabled" (
    echo Cinders is enabled, switch to your Alt Steam Account if playing online to avoid a ban!
) else (
    echo Cinders is disabled, don't forget to switch back to your Main Steam account!
)

echo ================================
echo Options:
echo 1. Enable Mod
echo 2. Disable Mod
echo 3. Exit
echo ================================

rem User choice
set /p choice="Select an option (1-3): "

if "!choice!"=="1" (
    rem Enable the mod
    if "!mod_status!"=="Disabled" (
        echo Enabling mod...

        rem Rename DarkSoulsIII.exe to DarkSoulsIII.exe.bak
        if exist "%game_folder%\DarkSoulsIII.exe" (
            ren "%game_folder%\DarkSoulsIII.exe" "DarkSoulsIII.exe.bak"
        )

        rem Rename Cinders.exe to DarkSoulsIII.exe
        if exist "%game_folder%\Cinders.exe" (
            ren "%game_folder%\Cinders.exe" "DarkSoulsIII.exe"
        )

        rem Copy Clean save to Saves\Clean
        echo Copying Clean save to Saves\Clean...
        xcopy "%active_save%\*" "%saves_folder%\Clean\" /s /e /i /y >nul

        rem Clear the Active Save location
        echo Removing existing files in %active_save%...
        rd /s /q "%active_save%"
        mkdir "%active_save%"

        rem Copy Cinders save to Active Save
        echo Copying Cinders save to %active_save%...
        xcopy "%saves_folder%\Cinders\*" "%active_save%\" /s /e /i /y >nul

        rem Move mod files from Mods\Cinders to Game
        for %%f in (%mod_files%) do (
            echo Copying %%f from Mods\Cinders to Game...
            copy "%cinders_folder%\%%f" "%game_folder%\%%f" >nul
        )

        echo Mod has been enabled.
    ) else (
        echo Mod is already enabled.
    )
) else if "!choice!"=="2" (
    rem Disable the mod
    if "!mod_status!"=="Enabled" (
        echo Disabling mod...

        rem Rename DarkSoulsIII.exe back to Cinders.exe
        if exist "%game_folder%\DarkSoulsIII.exe" (
            ren "%game_folder%\DarkSoulsIII.exe" "Cinders.exe"
        )

        rem Rename DarkSoulsIII.exe.bak back to DarkSoulsIII.exe
        if exist "%game_folder%\DarkSoulsIII.exe.bak" (
            ren "%game_folder%\DarkSoulsIII.exe.bak" "DarkSoulsIII.exe"
        )

        rem Copy current Active Save to Saves\Cinders
        echo Copying current save to Saves\Cinders...
        xcopy "%active_save%\*" "%saves_folder%\Cinders\" /s /e /i /y >nul

        rem Clear the Active Save location
        echo Removing existing files in %active_save%...
        rd /s /q "%active_save%"
        mkdir "%active_save%"

        rem Copy Clean save to Active Save
        echo Copying Clean save to %active_save%...
        xcopy "%saves_folder%\Clean\*" "%active_save%\" /s /e /i /y >nul

        rem Move mod files from Game to Mods\Cinders
        for %%f in (%mod_files%) do (
            echo Moving %%f from Game to Mods\Cinders...
            move "%game_folder%\%%f" "%cinders_folder%\%%f" >nul
        )

        echo Mod has been disabled.
    ) else (
        echo Mod is already disabled.
    )
) else if "!choice!"=="3" (
    echo Exiting.
    exit /b
) else (
    echo Invalid choice. Please select 1, 2, or 3.
)

goto loop

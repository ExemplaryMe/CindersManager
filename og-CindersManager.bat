@echo off
cls

:intro
ECHO Dark Souls III Cinders Mod Manager
ECHO.

:pathKeysCheck
Rem Check for keys if exist go to mod manager, if not create them
ECHO Checking if registry keys exist
IF EXIST C:\keys.ini (goto readkeys) ELSE goto keycreation


:readkeys
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKCU\Cinders" /v "GameDir"') DO set "gamedir=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKCU\Cinders" /v "ModDir"') DO set "moddir=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKCU\Cinders" /v "SaveDir"') DO set "savedir=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKCU\Cinders" /v "SafeSaveDir"') DO set "safesavedir=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKCU\Cinders" /v "ModSaveDir"') DO set "modsavedir=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKCU\Cinders" /v "SafeSave"') DO set "safesave=%%B"
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKCU\Cinders" /v "ModSave"') DO set "modsave=%%B"
goto modmanagement


:keycreation

Rem User input for game path, mod path, where to keep save files and name of save data stored in registry keys
ECHO keys.ini does not exist, it will be created after entering paths
set /p gamedir="Enter path of Dark Souls 3 Game folder "C:\Dark Souls III\Game" :" 
REG ADD HKEY_CURRENT_USER\Cinders /v GameDir /d "%gamedir%"
REG QUERY HKEY_CURRENT_USER\Cinders /v GameDir
set /p moddir="Enter path of Dark Souls 3 Mods folder "C:\Dark Souls III\Mods" :"
REG ADD HKEY_CURRENT_USER\Cinders /v ModDir /d "%moddir%"
REG QUERY HKEY_CURRENT_USER\Cinders /v ModDir
set /p savedir="Enter path of Dark Souls 3 Save data (...AppData\Roaming\DarkSoulsIII) :"
REG ADD HKEY_CURRENT_USER\Cinders /v SaveDir /d "%savedir%"
REG QUERY HKEY_CURRENT_USER\Cinders /v SaveDir
set /p safesavedir="Enter path of where you want to keep your clean save data when not in use :"
REG ADD HKEY_CURRENT_USER\Cinders /v SafeSaveDir /d "%safesavedir%"
REG QUERY HKEY_CURRENT_USER\Cinders /v SafeSaveDir
set /p modsavedir="Enter path of where you want to keep Cinders save data when not in use :"
REG ADD HKEY_CURRENT_USER\Cinders /v ModSaveDir /d "%modsavedir%"
REG QUERY HKEY_CURRENT_USER\Cinders /v ModSaveDir
echo.
ECHO To handle saves correctly make sure savedata is already created for your Main Steam account and Secondary Steam account.
set /p safesave="Enter the name of the folder of clean save data: "
REG ADD HKEY_CURRENT_USER\Cinders /v SafeSave /d "%safesave%"
REG QUERY HKEY_CURRENT_USER\Cinders /v SafeSave
set /p modsave="Enter name of the folder of Cinders save data: "
REG ADD HKEY_CURRENT_USER\Cinders/v ModSave /d "%modsave%"
REG QUERY HKEY_CURRENT_USER\Cinders/v ModSave

echo.

ECHO Registry keys created successfully, creating true/false check ini file
>> C:\keys.ini

:modfiles
Rem Mod files are declared here and do not need to be changed
set mod="Cinders"
set dll="dinput8.dll"
set modengine="modengine.ini"

:install
Rem Mod gets installed here
ECHO Installing Cinders
echo.

IF EXIST %moddir%\%mod% ECHO Cinders Mod is not installed. Installing...
echo.
IF EXIST %moddir%\%mod% MOVE %moddir%\%mod% %gamedir%

IF EXIST %moddir%\%dll% MOVE %moddir%\%dll% %gamedir%

IF EXIST %moddir%\%modengine% MOVE %moddir%\%modengine% %gamedir%

:modsavefile
Rem Check if the mod exists in the save directory, if it does move the mod save into the AppData\Roaming\DarkSoulsIII

IF EXIST %gamedir%\%mod% ECHO Cinders Mod is installed, switching save files

echo.

MOVE %savedir%\%safesave% %safesavedir%\

MOVE %modsavedir%\%modsave% %savedir%\

echo Save files successfully switched
goto end

Rem Mod gets uninstalled here
:uninstall
ECHO Uninstalling Cinders
echo.

IF EXIST %gamedir%\%mod% ECHO Cinders Mod is currently installed. Uninstalling... 
echo.
IF EXIST %gamedir%\%modname% MOVE %gamedir%\%mod% %moddir%
 
IF EXIST %gamedir%\%dll% MOVE %gamedir%\%dll% %moddir%

IF EXIST %gamedir%\%modengine% MOVE %gamedir%\%modengine% %moddir% 

Rem If the mod no longer exsts in the game directory, move the mod save out of AppData\Roaming\DarkSoulsIII and put the regular save file back

:savefile
IF NOT EXIST %gamedir%\%modname% ECHO Cinders Mod is uninstalled, switching save files

echo.

MOVE %savedir%\%modsave% %modsavedir%

MOVE %safesavedir%\%safesave% %savedir%

echo Save files successfully switched
goto end2


Rem Start again to enable or disable mod
:modmanagement
echo.
echo Game path: %gamedir%
echo Mod path: %moddir%
echo.
echo Safe Savefile path: %safesavedir%
echo Safe Savefile name: %safesave%
echo.
echo Mod Savefile path: %modsavedir%
echo Mod Savefile name: %modsave%
echo.

set choice=
set /p choice="Enable(1) or Disable(2): "

if '%choice%'=='1' goto install
if '%choice%'=='2' goto uninstall



:end
echo.
ECHO Cinders Mod has been installed.
goto modmanagement

:end2
echo.
ECHO Cinders Mod has been uninstalled.
goto modmanagement


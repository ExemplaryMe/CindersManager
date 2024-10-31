# CindersManager
This script is a result of using ChatGPT to help me organize my idea for managing my Cinders for DarkSoulsIII.
OG script is included for historical purposes, that I tried writing, badly, and use registry keys :KEKW:

CindersManager.bat is the new script written with the help of ChatGPT, can probably still be improved.

# Pre-Req's for Script Use
Needs to live in `DARK SOULS III\`
Folders that must exist inside of `DARK SOULS III`, `DARK SOULS III\Game`,`DARK SOULS III\Mods`,`DARK SOULS III\Mods\Cinders`,`DARK SOULS III\Saves`, `DARK SOULS III\Saves\Clean`, `DARK SOULS III\Saves\Cinders` (create them if they don't exist) - this script won't touch the actual Cinders folder in `DARK SOULS III\Game\Cinders`

# Instructions READ FIRST AND CAREFULLY

# Purpose
This script is intended for the people who switch between two Steam Accounts in order to play Cinders and not incur a softban on their primary account.
I use https://github.com/TCNOco/TcNo-Acc-Switcher because it is godtier

# How Saves are Handled
Saves are kept in `%appdata%\DarkSoulsIII` and the game creates a folder with long string as a name, associated to the currently logged in Steam Account
Make note of which folder is your "Clean" save (non-Cinders steam account) and which is your "Cinders" save (Cinders steam account)
Stay in your current Steam account, launch DS3 without Cinders, Copy your "Clean" save folder to `DARK SOULS III\Saves\Clean` from `%appdata%\DarkSoulsIII`, delete after copying.
Switch to Cinders Steam account, launch DS3 with Cinders, copy your "Cinders" save folder to `DARK SOULS III\Saves\Cinders` from `%appdata%\DarkSoulsIII`, delete after copying.
You should have two folders inside of `Dark Souls III\Saves`, `Clean` and `Cinders` and they both contain differently named save folders that match each Steam profile.

# Setup & Use
The script lives at the root of your `Dark Souls III` folder.
It will look for paths `Game`, `Mods/Cinders`, and `Saves`.
EBABLE / DISABLE - It will move the Cinders mod files (not the Mod folder itself in `Game` but modengine and hoodie dll/ini), in and out of `Game` and `Mods\Cinders`

Enabling will copy the current "Clean" save folder from `%appdata%\DarkSoulsIII` to your `Dark Souls III\Saves\Clean path`, move modengine.ini, hoodiepatcher.ini, etc from `Mods\Cinders` to Game (thus enabling the mod) and remind you to switch Steam logins, as well as copy your "Cinders" save folder from Saves\Cinders to `%appdata%\DarkSoulsIII`

Disabling the mod will do the same but in reverse, your previously copied Cinders save is copied back to `DARK SOULS III\Saves\Cinders`, your `DARK SOULS III\Saves\Clean` save is copied back, the mod files are moved out of `Game` back to `Mods\Cinders`.

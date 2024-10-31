# CindersManager
This script is a result of using ChatGPT to help me organize my idea for managing my Cinders for DarkSoulsIII.
OG script is included for historical purposes

CindersManager.bat is the new script written with the help of ChatGPT, can probably still be improved.

# Pre-Req's for Script Use
Needs to live in DARKSOULSIII\
Folders that must exist inside of DARKSOULSIII "Game","Mods,"Cinders" inside of "Mods", "Saves", "Clean" and "Cinders" inside of Saves, (create them if they don't exist) - this script won't touch the actual Cinders folder that goes in "Game".

# Instructions READ FIRST AND CAREFULLY

# Purpose
This script is intended for the people who switch between two Steam Accounts in order to play Cinders and not incur a softban on their primary account.

# How Saves are Handled
Saves are kept in %appdata%\DarkSoulsIII and the game creates a folder with long string of names associated to the currently logged in Steam Account
Make note of which folder is your "Clean" save (non-Cinders steam account) and which is your "Cinders" save (Cinders steam account)
Stay in your current Steam account, launch DS3 without Cinders, Copy your "Clean" save folder to DARKSOULSIII\Saves\
Switch to Cinders Steam account, launch DS3 with Cinders, copy your "Cinders" save folder to DARKSOULSIII\Saves\
You should have two folders inside of Saves, "Clean" and "Cinders" and they both contain differently named save folders that match each Steam profile.

# Setup & Use
The script lives at the root of your DarkSoulsIII folder.
It will look for paths Game, Mods/Cinders, and Saves.
It will move the Cinders mod files (not the Mod folder itself in "Game"), in and out of \Game and \Mods\Cinders. (ENABLE, DISABLE)

Enabling the Mod will copy the current "Clean" save folder from %appdata%\DarkSoulsIII to your DarkSoulsIII\Saves\Clean path, move modengine.ini, hoodiepatcher.ini, etc from Mods\Cinders to Game (thus enabling the mod) and remind you to switch Steam logins, as well as copy your "Cinders" save folder from Saves\Cinders to %appdata%\DarkSoulsIII

Disabling the mod will do the same but in reverse, your "Cinders" save folder is now copied to "Saves", your "Clean" save is copied back, the mod files are moves out of "Game" back to "Mods\Cinders".

:: Name:     updateASS.bat
:: Purpose:  Copy Amaya's Spell Stealer files to WoW addons folder
:: Author:   @Amaya_PvP

@ECHO OFF

cls && echo Updating Amaya's SpellStealer addon...
copy /Y /B /V Amaya-Spellstealer "%WOW_ADDONS_HOME%\Amaya-Spellstealer" > NUL
:: Sleep for 2 seconds, then show success message
ping -n 2 127.0.0.1 > NUL && echo Amaya's SpellStealer addon updated successfully!
PAUSE
EXIT /B 0
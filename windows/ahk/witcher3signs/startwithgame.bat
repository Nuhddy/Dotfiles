@echo off

cd "C:\Program Files\AutoHotkey"
start AutoHotkey.exe "C:\PortablePrograms\AhkScripts\witcher3signs\main.ahk"

cd "C:\Games\GOG Galaxy"
start GalaxyClient.exe /command=runGame /gameId=1495134320 /path="C:\Games\GOG Galaxy\Games\The Witcher 3 Wild Hunt GOTY"

exit
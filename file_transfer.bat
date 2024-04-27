@echo off
setlocal enabledelayedexpansion

set "source=C:\Clery\DailyLogArchive"

for /f "tokens=3" %%a in ('echo %date%') do set "year=%%a"

set "yearText=2024"

set "destination=Y:\Clery Daily Crime Log\!yearText!"

move "%source%\*" "%destination%"

pause

endlocal
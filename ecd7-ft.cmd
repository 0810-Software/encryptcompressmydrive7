@powershell -window hidden -command ""
set /a ft7sessionnumber=(%RANDOM%*500/32768)+1
md "%tmp%\ecd7-formattingtool_%ft7sessionnumber%.tmp"
cd /d "%tmp%\ecd7-formattingtool_%ft7sessionnumber%.tmp"
set "restorewd=cd /d %tmp%\ecd7-formattingtool_%ft7sessionnumber%.tmp"
:selectadrive
FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Select.drive1.hta"') do set drive=%%a
if not exist "%drive%" (
start /wait mshta "javascript:alert('This drive cannot be found.');window.close()"
goto selectadrive
)
set "quickswitch="
FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Quickswitchmenu1.hta"') do set quick=%%a
if "%quick%"=="1" set quickswitch=/q
format %DRIVE% /x /v:ecmd7 /fs:exFAT /y %quickswitch%
call :checkcon
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://github.com/Marnix0810/encryptcompressmydrive7/raw/master/files/ecd7-fs.7z', 'ecd7-fs_latest.7z') }"
CD /D %DRIVE%
"%~dp0bin\7za" X "%tmp%\ecd7-formattingtool_%ft7sessionnumber%.tmp\ecd7-fs_latest.7z" -o"%drive%\"
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Marnix0810/encryptcompressmydrive7/master/ecmversion.txt', 'latest_ecmversion.txt') }"
set /p "latestversion="<"latest_ecmversion.txt"
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Marnix0810/encryptcompressmydrive7/master/updurl.txt', 'updurl.txt') }"
set /p "updurl="<"updurl.txt"
call powershell -command "iwr -outf ECD_Software-%latestversion%.exe %updurl%"
del /f /q updurl.txt
del /f /q latest_ecmversion.txt
ECHO:>"\.clean"
cd /d "%tmp%\ecd7-formattingtool_%ft7sessionnumber%.tmp\"
start /wait mshta "javascript:alert('Format of drive %drive% complete.');window.close()"
REM start /b cmd /c "%tmp%\ecd7-formattingtool_%ft7sessionnumber%.tmp\ecd7-launcher.cmd"
:checkcon
SET Connected=false
FOR /F "usebackq tokens=1" %%A IN (`PING github.com`) DO (
    IF /I "%%A"=="Reply" SET Connected=true
)
If "%connected%"=="false" (
start mshta.exe "%~dp0GUI\1992.hta"
call :suspendforconnection
)
exit /b
:suspendforconnection
SET Connected=false
FOR /F "usebackq tokens=1" %%A IN (`PING github.io`) DO (
    IF /I "%%A"=="Reply" SET Connected=true
)
If "%connected%"=="false" (
goto suspendforconnection
)
exit /b
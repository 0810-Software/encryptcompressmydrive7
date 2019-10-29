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
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://github.com/Marnix0810/encryptcompressmydrive7/raw/master/files/ecd7-fs.7z', 'ecd7-fs_latest.7z') }"
cd /d %drive%\
%~dp0bin\7za X "%tmp%\ecd7-formattingtool_%ft7sessionnumber%.tmp\ecd7-fs_latest.7z" -o"%drive%\"
CD /D %DRIVE%
ECHO:>"\.clean"
cd /d "%tmp%\ecd7-formattingtool_%ft7sessionnumber%.tmp\"
start /wait mshta "javascript:alert('Format of drive %drive% complete.');window.close()"
REM start /b cmd /c "%tmp%\ecd7-formattingtool_%ft7sessionnumber%.tmp\ecd7-launcher.cmd"
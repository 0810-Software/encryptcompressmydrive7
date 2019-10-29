@powershell -window hidden -command ""
set /a u7sessionnumber=(%RANDOM%*500/32768)+1
md "%tmp%\ecd7-updatetool_%u7sessionnumber%.tmp"
cd /d "%tmp%\ecd7-updatetool_%u7sessionnumber%.tmp"
set "restorewd=cd /d %tmp%\ecd7-updatetool_%u7sessionnumber%.tmp"
:searchupdateprogram
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Marnix0810/encryptcompressmydrive7/master/ecmversion.txt', 'latest_ecmversion.txt') }"
set /p "latestversion="<"latest_ecmversion.txt"
set /p "currentversion="<"%~dp0ecmversion.txt"
if not "%latestversion%"=="%currentversion%" call :updateprogram
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Marnix0810/encryptcompressmydrive7/master/files/latest_ecmdriveversion.txt', 'latest_ecmdriveversion.txt') }"
:search
@powershell -window hidden -command ""
set "ecmdrive7="
set /a loop+=1
set /p "latest_ecmdriveversion="<"%cd%\latest_ecmdriveversion.txt"
for %%p in (A B D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%p:\ecmdriveversion.txt (
call :checkdver %%p
)
if "%ecmdrive7%"=="" (
echo [search #%loop%] No unupdated devices found.>>session%u7sessionnumber%.log
goto search
)
echo [search #%loop%] Unupdated device %ecmdrive7% found>>session%u7sessionnumber%.log
:start
%~dp0bin\notifu /m "The ecd7 drive at  is %ecmdrive7% being updated..." /t info /i "%~dp0img\Icon2.ico" /p "EncryptCompressMyDrive7 Updates" /d 2000
cd %ecmdrive7% /D
if exist "%ecmdrive7%\.ecmd.7" set 7opened=0
if exist "%ecmdrive7%\.ecmd.8" set 7opened=1
del /f /q "%ecmdrive7%\.ecmd.?"
echo [search #%loop%] Unupdated device %ecmdrive7% locked from opening or closing.>>session%u7sessionnumber%.log
%restorewd%
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://github.com/Marnix0810/encryptcompressmydrive7/raw/master/files/ecd7-fs.7z', 'ecd7-fs_latest.7z') }"
echo [search #%loop%] Downloaded image for unupdated device %ecmdrive7%>>session%u7sessionnumber%.log
cd %ecmdrive7% /D
%~dp0bin\7za a "%tmp%\ecd7-updatetool_%u7sessionnumber%.tmp\ecd7-fs_latest.7z" "%ecmdrive7%\ecd7db.files" -r
%~dp0bin\7za a "%tmp%\ecd7-updatetool_%u7sessionnumber%.tmp\ecd7-fs_latest.7z" "%ecmdrive7%\ecmd7.files" -r
%restorewd%
echo [search #%loop%] Backed up device at %ecmdrive7%.>>session%u7sessionnumber%.log
echo [search #%loop%] Format device at %ecmdrive7% start.>>session%u7sessionnumber%.log
format %ecmdrive7% /x /v:ecmd7 /fs:exFAT /y /q
echo [search #%loop%] Format device at %ecmdrive7% complete.>>session%u7sessionnumber%.log
cd %ecmdrive7% /D
echo [search #%loop%] Write device at %ecmdrive7% start.>>session%u7sessionnumber%.log
%~dp0bin\7za X "%tmp%\ecd7-updatetool_%u7sessionnumber%.tmp\ecd7-fs_latest.7z" -o"%ecmdrive7%\"
echo [search #%loop%] Write device at %ecmdrive7% complete.>>session%u7sessionnumber%.log
if "%7opened%"=="1" (
ren %ecmdrive7%\.ecmd.7 .ecmd.8
)
%restorewd%
%~dp0bin\notifu /m "The ecd7 drive at %ecmdrive7% has been updated" /t info /i "%~dp0img\Icon2.ico" /p "EncryptCompressMyDrive7 Updates" /d 0
echo [search #%loop%] Updated device at %ecmdrive7%.>>session%u7sessionnumber%.log
goto search

:checkdver
set /p "latest_ecmdriveversion="<"%cd%\latest_ecmdriveversion.txt"
cd %1:\ /D
set /p installed_ecmdriveversion=<%1:\ecmdriveversion.txt
if not "%installed_ecmdriveversion%"=="%latest_ecmdriveversion%" (
set ecmdrive7=%1:
)
%restorewd%
exit /b

:updateprogram
%~dp0bin\notifu /m "The ecd7 program is downloading updates..." /t info /i "%~dp0img\Icon2.ico" /p "EncryptCompressMyDrive7 Updates" /d 0
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Marnix0810/encryptcompressmydrive7/master/updurl.txt', 'updurl.txt') }"
set /p "updurl="<"updurl.txt"
call powershell -command "iwr -outf ECD-program_update.exe %updurl%"
start /wait ECD-program_update.exe
exit /b
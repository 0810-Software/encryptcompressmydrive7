@powershell -window hidden -command ""
set /a u7sessionnumber=(%RANDOM%*500/32768)+1
md "%tmp%\ecd7-updatetool_%u7sessionnumber%.tmp"
cd /d "%tmp%\ecd7-updatetool_%u7sessionnumber%.tmp"
set "restorewd=cd /d %tmp%\ecd7-updatetool_%u7sessionnumber%.tmp"
:searchupdateprogram
call :checkcon
call :checkisadmin
if "%isadmin%"=="n" goto search
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/0810-software/encryptcompressmydrive7/master/ecmversion.txt', 'latest_ecmversion.txt') }"
set /p "latestversion="<"latest_ecmversion.txt"
set /p "currentversion="<"%~dp0ecmversion.txt"
if not "%latestversion%"=="%currentversion%" call :updateprogram
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/0810-Software/ECD7-FSImages/master/ecmdriveversion.txt', 'latest_ecmdriveversion.txt') }"
:search
@powershell -window hidden -command ""
call :checkcon
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
"%~dp0bin\notifu" /m "The ecd7 drive at  is %ecmdrive7% being updated..." /t info /i "%~dp0img\Icon2.ico" /p "EncryptCompressMyDrive7 Updates" /d 2000
cd %ecmdrive7% /D
if exist "%ecmdrive7%\.ecmd.8" call :unmountforupdate
del /f /q "%ecmdrive7%\.ecmd.?"
echo [search #%loop%] Unupdated device %ecmdrive7% locked from opening or closing.>>session%u7sessionnumber%.log
%restorewd%
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://github.com/0810-Software/ECD7-FSImages/archive/%latest_ecmdriveversion%.zip', 'ecd7-fs_latest.zip') }"
echo [search #%loop%] Downloaded image for unupdated device %ecmdrive7%>>session%u7sessionnumber%.log
cd %ecmdrive7% /D
"%~dp0bin\7za" a "%tmp%\ecd7-updatetool_%u7sessionnumber%.tmp\ecd7-fs_latest.zip" "%ecmdrive7%\ecd7db.files" -r
"%~dp0bin\7za" a "%tmp%\ecd7-updatetool_%u7sessionnumber%.tmp\ecd7-fs_latest.zip" "%ecmdrive7%\ecmd7.files" -r
%restorewd%
echo [search #%loop%] Backed up device at %ecmdrive7%.>>session%u7sessionnumber%.log
echo [search #%loop%] Format device at %ecmdrive7% start.>>session%u7sessionnumber%.log
format %ecmdrive7% /x /v:ecmd7 /fs:exFAT /y /q
echo [search #%loop%] Format device at %ecmdrive7% complete.>>session%u7sessionnumber%.log
cd %ecmdrive7% /D
echo [search #%loop%] Write device at %ecmdrive7% start.>>session%u7sessionnumber%.log
"%~dp0bin\7za" X "%tmp%\ecd7-updatetool_%u7sessionnumber%.tmp\ecd7-fs_latest.zip" -o"%ecmdrive7%\"
echo [search #%loop%] Write device at %ecmdrive7% complete.>>session%u7sessionnumber%.log
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/0810-software/encryptcompressmydrive7/master/ecmversion.txt', 'latest_ecmversion.txt') }"
set /p "latestversion="<"latest_ecmversion.txt"
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/0810-software/encryptcompressmydrive7/master/updurl.txt', 'updurl.txt') }"
set /p "updurl="<"updurl.txt"
call powershell -command "iwr -outf ECD_Software-%latestversion%.exe %updurl%"
del /f /q updurl.txt
del /f /q latest_ecmversion.txt
%restorewd%
"%~dp0bin\notifu" /m "The ecd7 drive at %ecmdrive7% has been updated" /t info /i "%~dp0img\Icon2.ico" /p "EncryptCompressMyDrive7 Updates" /d 0
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
"%~dp0bin\notifu" /m "The ecd7 program is downloading updates..." /t info /i "%~dp0img\Icon2.ico" /p "EncryptCompressMyDrive7 Updates" /d 0
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/0810-software/encryptcompressmydrive7/master/updurl.txt', 'updurl.txt') }"
set /p "updurl="<"updurl.txt"
call powershell -command "iwr -outf ECD-update.exe %updurl%"
start /wait ECD-update.exe
exit /b

:unmountforupdate
FOR /F "usebackq tokens=1,2* delims=," %%G IN ("%ecmdrive7%\ecd7db.files\sav.ecd7db") DO SET %%G
del /f /q "%ecmdrive7%\ecd7db.files\sav.ecd7db"
del /f /q  "%ecmdrive7%\ecmd7.files\%Uname7%.ecmd7"
cd /d "%ecmdlocation7%"
md "%tmp%\ecmd7\%mountpointnumber7%"
"%~dp0bin\7za" a "%ecmdrive7%\ecmd7.files\%Uname7%.ecmd7" * -t7z -r -mhe -sdel -w"%tmp%\ecmd7\%mountpointnumber7%" -p"%Upw7%"
cd /d "%~dp0"
subst /d %Mounttovolume7%
set "Mounttovolume7="
rd /S /Q "%ecmdlocation7%"
ren %ecmdrive7%\.ecmd.8 .ecmd.7
exit /b
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
:checkisadmin
setlocal EnableDelayedExpansion
set user=%username%
net user %user% | find "Local Group Memberships">temp.tmp
for /f %%a in ('findstr /i "Administrators" temp.tmp') do (
    set isadmin=y
    del temp.tmp
    goto checkisadminR
)
set isadmin=n
del temp.tmp
pause
goto checkisadminR
:checkisadminR
exit /b
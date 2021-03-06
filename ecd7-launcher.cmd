@powershell -window hidden -command ""
start "" "%~dp0ecd7-updater.cmd"
:search
set "ecmdrive7="
:search.unlock
for %%p in (A B D E F G H I J K L M N O P Q R S T U V W X Y Z) do if  exist %%p:\.ecmd.9 (
"%~dp0bin\notifu" /m "Remounting your drive in 15 seconds..." /t info /i "%~dp0img\Icon2.ico" /p "EncryptCompressMyDrive7 Updates" /d 0
timeout /t 15
ren %%p:\.ecmd.9 .ecmd.7
"%~dp0bin\notifu" /m "Please log back in to your ECMD7 drive." /t info /i "%~dp0img\Icon2.ico" /p "EncryptCompressMyDrive7 Updates" /d 0
)
:search.main
for %%p in (A B D E F G H I J K L M N O P Q R S T U V W X Y Z) do if  exist %%p:\.ecmd.7 (
set ecmdrive7=%%p:
goto start
)
if "%ecmdrive7%"=="" (
goto search
)
:start
if exist "%ecmdrive7%\.clean" goto clean
call :userinput_25617
if not exist "%ecmdrive7%\ecmd7.files\%Uname7%.ecmd7" (
    call :userinput_25616
    If "%Upw7%"=="" goto start
) ELSE (
    call :userinput_1978
)
:create
set /a mountpointnumber7=%random%+1
set "ecmdlocation7=%appdata%\ecmd7\%mountpointnumber7%"
md "%ecmdlocation7%"
md "%tmp%\ecmd7\%mountpointnumber7%"
if exist "%ecmdrive7%\ecmd7.files\%Uname7%.ecmd7" (
call :948372863
)
if exist "%ecmdrive7%\.clean" (
    del /f /q "%ecmdrive7%\.clean"
)

:mount
for %%p in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if not exist %%p:\nul set Mounttovolume7=%%p:
subst %Mounttovolume7% "%ecmdlocation7%"
start explorer "%Mounttovolume7%"
(
    echo ;ecd7-savepoint
    set Uname7
    set Upw7
    set ecmdrive7
    set Mounttovolume7
    set ecmdlocation7
    set mountpointnumber7
)> "%ecmdrive7%\ecd7db.files\sav.ecd7db"
ren %ecmdrive7%\.ecmd.7 .ecmd.8
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%Mounttovolume7%\Logoff, unmount and write data to drive.lnk');$s.TargetPath='%~dp0ecd7-unmount.cmd';$s.Save()"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%ecmdrive7%\Logoff, unmount and write data to drive.lnk');$s.TargetPath='%~dp0ecd7-unmount.cmd';$s.Save()"
goto search
:clean
call :userinput_89028
call :userinput_25616
goto create

:userinput_89028
set "Uname7="
FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Username.clean1.hta"') do set Uname7=%%a
if "%Uname7%"=="" (
timeout /t 30
goto search
)

:userinput_25617
set "Uname7="
FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Username.hta"') do set Uname7=%%a
if "%Uname7%"=="" (
timeout /t 30
goto search
)
exit /b
:userinput_25616
set "Upw7="
FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Password.clean1.hta"') do set Upw7=%%a
if "%Upw7%"=="" goto :userinput_25616
exit /b

:userinput_1978
set "Upw7="
FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Password.hta"') do set Upw7=%%a
if "%Upw7%"=="" goto :userinput_1978
exit /b

:948372863
"%~dp0bin\7za" X "%ecmdrive7%\ecmd7.files\%Uname7%.ecmd7"  -t7z -o"%ecmdlocation7%\" -p"%Upw7%" -w"%tmp%\ecmd7\%mountpointnumber7%" || (
"%~dp0bin\notifu" /m "Your ECD7 drive is expireincing problems. Password typo? please remount drive and try again." /t info /i "%~dp0img\Icon2.ico" /p "EncryptCompressMyDrive7 Updates" /d 0
timeout /t 30
goto search
)
exit /b
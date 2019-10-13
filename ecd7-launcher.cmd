REM @powershell -window hidden -command ""
:search
for %%p in (A B D E F G H I J K L M N O P Q R S T U V W X Y Z) do if  exist %%p:\.ecmd.7 (
set ecmdrive7=%%p:
goto start
)
if "%ecmdrive7%"=="" (
REM Start over searching if not found
goto search
)
:start
if exist "%ecmdrive7%\.clean" goto clean
FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Username.hta"') do set Uname7=%%a
if not exist "%ecmdrive7%\ecmd7.files\%Uname7%.ecmd7" (
    FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Password.clean1.hta"') do set Upw7=%%a
) ELSE (
    FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Password.hta"') do set Upw7=%%a
)
:create
set /a mountpointnumber7=%random%+1
set "ecmdlocation7=%appdata%\ecmd7\%mountpointnumber7%"
md "%ecmdlocation7%"
if exist "%ecmdrive7%\ecmd7.files\%Uname7%.ecmd7" (
    %~dp0bin\7za X "%ecmdrive7%\ecmd7.files\%Uname7%.ecmd7" -o"%ecmdlocation7%\"
)
if exist "%ecmdrive7%\.clean" (
    del /f /q "%ecmdrive7%\.clean"
)

:mount
for %%p in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if not exist %%p:\nul set Mounttovolume7=%%p:
subst %Mounttovolume7% "%ecmdlocation7%"
pause
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
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%FREEDRIVE%\Logoff, unmount and write data to drive.lnk');$s.TargetPath='%~dp0ecd7-unmount.cmd';$s.Save()"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%ecmdrive7%\Logoff, unmount and write data to drive.lnk');$s.TargetPath='%~dp0ecd7-unmount.cmd';$s.Save()"
exit
:clean
FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Username.clean1.hta"') do set Uname7=%%a
FOR /f "delims=" %%a in ('mshta.exe "%~dp0GUI\Password.clean1.hta"') do set Upw7=%%a
goto create
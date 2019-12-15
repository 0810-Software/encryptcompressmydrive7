@powershell -window hidden -command ""
:search
set "ecmdrive7="
for %%p in (A B D E F G H I J K L M N O P Q R S T U V W X Y Z) do if  exist %%p:\.ecmd.8 (
set ecmdrive7=%%p:
goto start
)
if "%ecmdrive7%"=="" (
goto search
)
:start
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
ren %ecmdrive7%\.ecmd.8 .ecmd.9
start /wait mshta "javascript:alert('You can now use Safe Eject to eject %ecmdrive7%.');window.close()"

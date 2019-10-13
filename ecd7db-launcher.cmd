@powershell -window hidden -command ""
echo off
cls
REM Search for any drives
:search
for %%p in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if  exist %%p:\.ecmd.7 (
REM start the system when found
) ELSE (
REM Start over searching if not found
goto search
)

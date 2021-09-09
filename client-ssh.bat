@echo off
:ssh
title ssh - offline
cls
echo SSH CLIENT
echo [1] Create SSH profile.
echo [2] Connect with SSH profile.
echo [3] Last connection.
echo [4] Exit.
echo.
set /p ssh=
if "%ssh%"=="1" (goto ssh-profile-create)
if "%ssh%"=="2" (goto ssh-connect)
if "%ssh%"=="3" (goto ssh-last-connection)
if "%ssh%"=="4" (exit)
echo "%SSH%" SSH command not found. | nhcolor 0c 
pause>nul
goto ssh
:ssh-profile-create
title ssh - creating a profile
set /p ssh-profile=Name for the SSH profile: 
set /p ssh-ip=Ip: 
set /p ssh-login=Login: 
set /p ssh-password=Password (optional): 
(echo.set ssh-ip=%ssh-ip%
echo.set ssh-login=%ssh-login%
echo.set ssh-password=%ssh-password%)>profiles\%ssh-profile%.profile
echo "%ssh-profile%" SSH profile has been created. | nhcolor 02
pause>nul
goto ssh
:ssh-connect
title ssh - connection..
set /p ssh-profile=Profile SSH: 
if not exist "profiles\%ssh-profile%.profile" (echo "profiles\%ssh-profile%" SSH profile not found. |nhcolor 0c  && pause>nul && goto ssh)
rename profiles\%ssh-profile%.profile %ssh-profile%.bat
call profiles\%ssh-profile%.bat
rename profiles\%ssh-profile%.bat %ssh-profile%.profile
(echo.set ssh-ip=%ssh-ip%
echo.set ssh-login=%ssh-login%
echo.set ssh-password=%ssh-password%)>last-connection.profile
echo Password: %ssh-password%
title ssh - Connect: %ssh-login%@%ssh-ip%
ssh %ssh-login%@%ssh-ip%
title ssh - Connection is broken
echo.
echo The connection is broken. | nhcolor 0c 
pause>nul
goto ssh
:ssh-last-connection
title ssh - connection..
if not exist "last-connection.profile" (echo Last-connection SSH profile not found. | nhcolor 0c && pause>nul && goto ssh)
rename last-connection.profile last-connection.bat
call last-connection.bat
rename last-connection.bat last-connection.profile
echo Password: %ssh-password%
title ssh - Connect: %ssh-login%@%ssh-ip%
ssh %ssh-login%@%ssh-ip%
title ssh - Connection is broken
echo.
echo The connection is broken. | nhcolor 0c 
pause>nul
goto ssh
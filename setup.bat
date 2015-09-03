@echo off
echo off

ECHO INSTALLING GEMS...
ECHO ======================================================
ECHO.
call bundle install
ECHO.

ECHO CREATING SHORTCUT...
ECHO ======================================================
ECHO.
ruby setup\setup.rb
ECHO Created!
ECHO.

ECHO ======================================================
ECHO Done!
ECHO.
pause

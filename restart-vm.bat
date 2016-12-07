@echo off
setlocal
:PROMPT
SET /P "AREYOUSURE=This will (re-)start the existing vagrant machine Are you sure? [y/N] "
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

echo ==^> Shutting down machine (if running)...
vagrant halt
vagrant halt -f

echo ==^> Starting up...
vagrant up

:END
endlocal

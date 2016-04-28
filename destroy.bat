@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=Are you sure you want to destroy the existing VM and undo changes done by init.bat? [y/N] 
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

vagrant destroy -f
rd /s /q ".vagrant"
rd /s /q "%HOMEDRIVE%%HOMEPATH%\.homestead"

:END
endlocal
@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=Are you sure you want to destroy the VM and delete created files? [y/N] 
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

vagrant destroy -f
echo ==^> Deleting files and folders...
rd /s /q ".vagrant"
rd /s /q "Code\lara-vedst"
rd /s /q "%HOMEDRIVE%%HOMEPATH%\.homestead"

:END
endlocal
@echo off
setlocal

set homesteadRoot=%HOMEDRIVE%%HOMEPATH%\.homestead

mkdir "%homesteadRoot%"

copy /-y src\stubs\Homestead.yaml "%homesteadRoot%\Homestead.yaml"
copy /-y src\stubs\after.sh "%homesteadRoot%\after.sh"
copy /-y src\stubs\aliases "%homesteadRoot%\aliases"

set /P "REPO=Which repository do you want to work in? [https://github.com/ILSCeV/lara-vedst.git] "
if /I "%REPO%" == "" set REPO="https://github.com/ILSCeV/lara-vedst.git"

set /P "BRANCH=Which branch do you want to work on? [master] "
if /I "%BRANCH%" == "" set BRANCH="master"

REM 'fart.exe' doesn't work with Windows 10
REM src\fart.exe --quiet %homesteadRoot%\after.sh REPOSITORY_URL_HERE %REPO%
REM src\fart.exe --quiet %homesteadRoot%\after.sh BRANCH_NAME_HERE %BRANCH%

powershell -Command "(gc %homesteadRoot%\after.sh) -replace 'REPOSITORY_URL_HERE', '%REPO%' | Set-Content -Path %homesteadRoot%\after.sh"
powershell -Command "(gc %homesteadRoot%\after.sh) -replace 'BRANCH_NAME_HERE', '%BRANCH%' | Set-Content -Path %homesteadRoot%\after.sh"

set /P "EXECUTE=Do you want to execute 'vagrant up' now? [y/N] "
if /I "%EXECUTE%" == "Y" vagrant up

endlocal

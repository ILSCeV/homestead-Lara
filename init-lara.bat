@echo off
setlocal

set homesteadRoot=%HOMEDRIVE%%HOMEPATH%\.homestead

mkdir "%homesteadRoot%"

copy /-y src\stubs\Homestead.yaml "%homesteadRoot%\Homestead.yaml"
copy /-y src\stubs\after.sh "%homesteadRoot%\after.sh"
copy /-y src\stubs\aliases "%homesteadRoot%\aliases"

SET /P REPO=Which repository do you want to work in? [https://github.com/tuiSSE/lara-vedst.git] 
IF /I "%REPO%" == "" set REPO="https://github.com/tuiSSE/lara-vedst.git"

SET /P BRANCH=Which branch do you want to work on? [devel-poll] 
IF /I "%BRANCH%" == "" set BRANCH="devel-poll"

src\fart.exe --quiet %homesteadRoot%\after.sh REPOSITORY_URL_HERE %REPO%
src\fart.exe --quiet %homesteadRoot%\after.sh BRANCH_NAME_HERE %BRANCH%

SET /P EXECUTE=Do you want to execute 'vagrant up' now? [y/N] 
IF /I "%EXECUTE%" == "Y" vagrant up

endlocal
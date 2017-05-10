@echo off
setlocal

copy /Y resources\Homestead.yaml Homestead.yaml
copy /Y resources\after.sh after.sh
copy /Y resources\aliases aliases

set /P "REPO=Which repository do you want to work in? [https://github.com/ILSCeV/Lara.git] "
if /I "%REPO%" == "" set REPO="https://github.com/ILSCeV/Lara.git"

echo.
echo List of available remote branches (ignore 'refs/heads/'):
git ls-remote --heads "%REPO%"
echo.

set /P "BRANCH=Which branch do you want to work on? [master] "
if /I "%BRANCH%" == "" set BRANCH="master"

powershell -Command "(gc after.sh) -replace 'REPOSITORY_URL_HERE', '%REPO%' | Set-Content -Path after.sh"
powershell -Command "(gc after.sh) -replace 'BRANCH_NAME_HERE', '%BRANCH%' | Set-Content -Path after.sh"

set /P "EXECUTE=Do you want to execute 'vagrant up' now? [y/N] "
if /I "%EXECUTE%" == "Y" vagrant up

endlocal

@echo off

set TT=%TEMP%
mkdir %TT% >nul 2>nul
mkdir %TT%\dx90c > nul 2>nul

echo Direct X �����^�C����W�J���Ă��܂��B
DIRECTX.exe /Q /C /T:%TT%\dx90c 

echo Direct X �����^�C�����C���X�g�[�����Ă��܂��B
%TT%\dx90c\dxsetup.exe /silent

del /q /s %TT%\dx90c >NUL

:end

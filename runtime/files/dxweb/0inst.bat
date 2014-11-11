@echo off

set TT=%TEMP%
mkdir %TT% >nul 2>nul
mkdir %TT%\dx90c > nul 2>nul

echo Direct X ランタイムを展開しています。
DIRECTX.exe /Q /C /T:%TT%\dx90c 

echo Direct X ランタイムをインストールしています。
%TT%\dx90c\dxsetup.exe /silent

del /q /s %TT%\dx90c >NUL

:end

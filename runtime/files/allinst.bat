@echo off
cls
echo ■■■ Microsoft ランタイムインストーラ ■■■

if not "%ProgramFiles(x86)%"=="" goto x64

:x86
echo Windows 32bit OSと認識されました。
set copydir=%windir%\system32
goto copy

:x64
echo Windows 64bit OSと認識されました。
set copydir=%windir%\syswow64
goto copy

:copy
cd vcp
call 0install.bat
cd ..\vb456
call 0install.bat
cd ..\vcredist
call 0install.bat
cd ..\dxweb
call 0install.bat

cd /d %~dp0
wscript %~dp0\complete.vbs

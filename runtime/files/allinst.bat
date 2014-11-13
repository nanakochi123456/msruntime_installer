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
rem ----
echo システムの復元ポイントの生成中 (インストール前)
makesystemrestorepoint.exe /silent msruntime_before

rem ----
makesystemrestorepoint.exe /silent /begin vcp_installed
set VCPSEQ=%ERRORLEVEL%
cd vcp
call 0install.bat
cd ..
echo システムの復元ポイントの生成中 (VCPインストール完了)
makesystemrestorepoint.exe /silent /end %VCPSEQ%

rem ----
makesystemrestorepoint.exe /silent /begin vb456_installed
set VBSEQ=%ERRORLEVEL%
cd vb456
call 0install.bat
cd ..
echo システムの復元ポイントの生成中 (VBRインストール完了)
makesystemrestorepoint.exe /silent /end %VBSEQ%

rem ----
cd vcredist
call 0install.bat
cd ..

rem ----
makesystemrestorepoint.exe /silent /begin directx_installed
set DXSEQ=%ERRORLEVEL%
cd \dxweb
call 0install.bat
cd ..
echo システムの復元ポイントの生成中 (DirectXインストール完了)
makesystemrestorepoint.exe /silent /end %DXSEQ%

rem ----
cd /d %~dp0
wscript %~dp0\complete.vbs

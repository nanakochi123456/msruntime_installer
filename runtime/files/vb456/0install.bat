@echo off

if not "%ProgramFiles(x86)%"=="" goto x64

:x86
set copydir=%windir%\system32
goto next

:x64
set copydir=%windir%\syswow64
goto next

:next

if "%1" == "" goto all
if "%1" == "inst" goto inst

:inst
SET TYPE=%2
SET SEQNO=%3
SET DLLNAME=%4
SET PKGNAME=%5
SET PKGTITLE=%6

IF EXIST %copydir%\%DLLNAME% (
  echo %DLLNAME%はインストール済です （%SEQNO%）
) ELSE (
  echo %DLLNAME%をインストールしています （%SEQNO%）
  echo copy %DLLNAME% %copydir%
  copy %DLLNAME% %copydir%
rem >NUL 2>NUL
)
regsvr32 /s %copydir%\%DLLNAME%

goto end

:all
echo Visual BASIC 4,5,6(SP6)ランタイムをインストールしています。


:copy
for /F "USEBACKQ TOKENS=1-4" %%A IN (vb456.inf) DO (
  IF /I     "%%C"=="dll" (
    call %0 inst dll %%A %%B %%D
  ) ELSE IF "%%C"=="ocx" (
    call %0 inst dll %%A %%B %%D
  ) ELSE (
    call %0 inst dll %%A %%B %%D
  )
)

:end

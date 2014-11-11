@echo off
setlocal ENABLEDELAYEDEXPANSION
set TEST1=%4
set TEST2=!TEST1:"=!

if exist %2 (
  if not "%~z2"=="%3" (
    del %2 >nul 2>nul
  )
)

if not exist %2 (
  echo %TEST2%をダウンロードしています
  ..\wget\curl --output %2 --progress-bar %1
)

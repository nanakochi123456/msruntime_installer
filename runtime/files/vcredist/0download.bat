@echo off

if "%1" == "" goto all

:dl
..\wget\fetch.bat %1 %2 %3 %5
goto end

:all

if not "%ProgramFiles(x86)%"=="" goto x64

goto x86

:x64
for /F "USEBACKQ TOKENS=1-5 DELIMS=," %%A IN (vcredist_x64.inf) DO (
  call %0 %%A %%B %%E "%%C" "%%D"
)

:x86
for /F "USEBACKQ TOKENS=1-5 DELIMS=," %%A IN (vcredist_x86.inf) DO (
  call %0 %%A %%B %%E "%%C" "%%D"
)

:end

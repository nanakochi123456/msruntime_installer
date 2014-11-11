@echo off

if "%1" == "" goto all

:dl
..\wget\fetch.bat %1 %2 %3 %5
goto end

:all

if not "%ProgramFiles(x86)%"=="" goto x64

goto x86

:x64
:x86

for /F "USEBACKQ TOKENS=1-5 DELIMS=," %%A IN (directx.inf) DO (
  call %0 %%A %%B %%E "%%C" "%%D"
)

:end

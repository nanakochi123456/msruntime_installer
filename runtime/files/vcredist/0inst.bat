@echo off

if not "%ProgramFiles(x86)%"=="" goto x64

goto x86

:x64
for /F "USEBACKQ TOKENS=1-4 DELIMS=," %%A IN (vcredist_x64.inf) DO (
  echo %%D ���C���X�g�[�����Ă��܂��B
  %%B %%C
)

:x86
for /F "USEBACKQ TOKENS=1-4 DELIMS=," %%A IN (vcredist_x86.inf) DO (
  echo %%D ���C���X�g�[�����Ă��܂��B
  %%B %%C
)

:end

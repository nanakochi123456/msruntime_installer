@echo off

if "%1"=="download" (
  cd files\dxweb
  call 0download.bat
  cd ..\vcredist
  call 0download.bat
  cd ..\..
  goto end
)

if "%1"=="distclean" (
  del files\dxweb\*.exe
  del files\vcredist\*.exe
  del files\complete.inf
  del files\readme.txt
  goto end
)

echo "Build listfile"
cd build
copy x:\site\winsppm\updater\list\default_w7_x64.lst .
c:\perl\bin\perl spmaker_parse_directx.pl
c:\perl\bin\perl spmaker_parse_vcredist.pl
copy directx.inf ..\files\dxweb
copy *.inf ..\files\vcredist
del directx.inf
del *.inf
cd ..

if "%1"=="" (
	SET TARGET=default
) ELSE (
	SET TARGET=%1
)
copy %TARGET%\*.* .

set APPNAME=msruntime
echo Make %APPNAME% for %TARGET%

del %TEMP%\7ztemp.7z
del *.cab
del msruntime_installer_%TARGET%.exe
del setup.exe
copy readme.txt files
copy complete.inf files
cd files
y:\tools\exedll\exedll -cfg=cab -a -r -o -i -ms ..\runtimes.cab *.*
cd ..
call y:\tools\exepress\exepress.bat runtimes.ini
y:\tools\7z\7z a %TEMP%\7ztemp.7z setup.exe -r -t7z -mx=9 -m0=LZMA:d30:a5:fb255:lc6  -mmt=6
copy /b build\7zSd.sfx + build\config.txt + %TEMP%\7ztemp.7z msruntime_installer_%TARGET%.exe
:end

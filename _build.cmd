@echo off
diff -u config.h.org config.h > config.h.diff
diff -u util.c.org util.c > util.c.diff
SET WATCOM=E:\compilers\WATCOM

set ENDLIBPATH=%ENDLIBPATH%;%WATCOM%\BINP\DLL
set path=%path%;%WATCOM%\BINP;%WATCOM%\BINW;e:\os2tk45\bin
set help=%help%;%WATCOM%\BINP\HELP
set bookshelf=%bookshelf%;%WATCOM%\BINP\HELP
SET INCLUDE=%WATCOM%\H\OS2;%WATCOM%\H;.
SET EDPATH=%WATCOM%\EDDAT

for %%d in (*.err *.obj *.exe ..\*.exe) do if exist %%d del %%d

if not exist output mkdir output

wcl386 -q -fe=output\dmidecode.exe  dmidecode.c dmiopt.c dmioem.c util.c getopt.c getopt1.c
if not exist  output\dmidecode.exe goto :error

wcl386 -q -fe=output\biosdecode.exe biosdecode.c                  util.c getopt.c getopt1.c
if not exist  output\biosdecode.exe goto :error

wcl386 -q -fe=output\ownership.exe  ownership.c                   util.c getopt.c getopt1.c
if not exist  output\ownership.exe goto :error

wcl386 -q -fe=output\vpddecode.exe  vpddecode.c vpdopt.c          util.c getopt.c getopt1.c
if not exist  output\vpddecode.exe goto :error

call lxlite output\*.exe

for %%d in (*.err *.obj) do if exist %%d del %%d
goto :end

:error
echo %0: error
pause

:end

@echo off
diff -u config.h.org config.h > config.h.diff
diff -u util.c.org util.c > util.c.diff
SET WATCOM=E:\compilers\WATCOM

set ENDLIBPATH=%ENDLIBPATH%;%WATCOM%\BINP\DLL
set path=%path%;%WATCOM%\BINP;%WATCOM%\BINW
set help=%help%;%WATCOM%\BINP\HELP
set bookshelf=%bookshelf%;%WATCOM%\BINP\HELP
SET INCLUDE=%WATCOM%\H\OS2;%WATCOM%\H;.
SET EDPATH=%WATCOM%\EDDAT

for %%d in (*.err *.obj *.exe ..\*.exe) do if exist %%d del %%d

wcl386 -q -fe=..\dmidecode.exe  dmidecode.c dmiopt.c dmioem.c util.c getopt.c getopt1.c
if not exist  ..\dmidecode.exe goto :error

wcl386 -q -fe=..\biosdecode.exe biosdecode.c                  util.c getopt.c getopt1.c
if not exist  ..\biosdecode.exe goto :error

wcl386 -q -fe=..\ownership.exe  ownership.c                   util.c getopt.c getopt1.c
if not exist  ..\ownership.exe goto :error

wcl386 -q -fe=..\vpddecode.exe  vpddecode.c vpdopt.c          util.c getopt.c getopt1.c
if not exist  ..\vpddecode.exe goto :error

call lxlite ..\*.exe

for %%d in (*.err *.obj) do if exist %%d del %%d
goto :end

:error
echo %0: error
pause

:end

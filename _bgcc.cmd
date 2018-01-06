path=%path%;e:\os2tk45\bin
make
if not exist gccbuild md gccbuild
copy *.exe gccbuild
lxlite gccbuild\*
make clean
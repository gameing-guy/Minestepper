REM delete previous files
DEL *.gb

REM compile .c files into .o files
C:\gbdk\bin\lcc -c -o main.o main.c
C:\gbdk\bin\lcc -c -o minestepperTiles.o ../res/minestepperTiles.c

REM Compile a .gb file from the compiled .o files
C:\GBDK\bin\lcc  -o minestepper.gb main.o minestepperTiles.o
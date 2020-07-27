asm68k main.s
link68 -o main.lnk main.o
sldr -St main.lnk logodemo.abs

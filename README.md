# calculator-using-flex-and-bison

run in command: 
bison -d icalc.y
flex icalc.l
gcc -o .\mytest.exe .\icalc.tab.c .\lex.yy.c
.\mytest.exe
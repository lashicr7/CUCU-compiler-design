Dasari Venkata Sai Lashyanth
2020CSB1083

bison -d cucu.l
 flex cucu.l
 gcc cucu.tab.c lex.yy.c -lfl -o cucu
 ./cucu input.txt
 Enter these commands for running the codes.Input.txt is the input file given

sample1.txt has correct c code where I have given functions described in the assignment document
sample2.txt has incorrect c code which will print error and stop the code at the error in the output file

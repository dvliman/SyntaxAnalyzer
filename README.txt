About:
======
A Syntax Analyzer implementation of LALR(1) parser with Context Free Grammar to process Toy Programming Language

How to run with Bash Script:
============================
sh build.sh 

How to run without Bash Script:
====================
yacc -d -v toy.y 
lex toy.l 
cc lex.yy.c y.tab.c -ly -ll
./a.out < input

Options Params:
===============
yacc
-d: generate y.tab.h (token definition)
-v: generate y.output (contains the parsing table and report of conflicts)

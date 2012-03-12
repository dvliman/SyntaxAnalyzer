About:
======
A Syntax Analyzer implementation of LALR(1) parser with Context Free Grammar to process Toy Programming Language

Requirements: 
=============
Lex and Yacc must be installed prior

How to run with Bash Script:
============================
sh build.sh 

How to run without Bash Script:
====================
yacc -d -v toy.y 
lex toy.l 
cc lex.yy.c y.tab.c -ly -ll
./a.out < input.toy

How to run the Test Cases:
==========================
./a.out < input.toy
./a.out < test/correct1.toy
./a.out < test/correct2.toy
./a.out < test/incorrect1.toy
./a.out < test/incorrect2.toy

Options Params:
===============
yacc
-d: generate y.tab.h (token definition)
-v: generate y.output (contains the parsing table and report of conflicts)

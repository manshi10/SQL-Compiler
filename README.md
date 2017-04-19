# SQL-Compiler
A lex-yacc implementation to mimic a pseudo SQL compiler 

Initial commit: Symbol Table Generation

The lexical, syntax and optimisation phases have been implemented.
The codes are in the respective folders.

Sample inputs for every phase are in the ip.sql files.

To compile:

lex lexfile.l
yacc -d yaccfile.y //(optional --debug --verbose flags can be provided for debugging purposes)
gcc y.tab.c lex.yy.c -o op
./op ip.sql // (optional output can be redirected to an output file. Sample outputs are also in the respective folders)

For any comments, or queries ping me. 

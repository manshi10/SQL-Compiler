%{
	#include"y.tab.h"
	#include<stdio.h>
	#include<string.h>
	
	int yyerror();
%}
%%
"CREATE TABLE"|"create table" {strcpy(yylval.var, yytext); return CREATE;}
"REFERENCES"|"references" {strcpy(yylval.var, yytext); return REFS;}
int|varchar|double|Date|True|False|Yes|No|byte {strcpy(yylval.var, yytext); return DTYPE;}
[0-9]+ {strcpy(yylval.var, yytext); return NUMBER;}
[A-Z]+ {strcpy(yylval.var, yytext); return TABLENAME;} 
[a-zA-Z][a-zA-Z0-9]* {strcpy(yylval.var, yytext); return ID;}
[\*]	{return yytext[0];}
,|\;|\(|\) {strcpy(yylval.var, yytext); return yytext[0];}
\t	;
[()\n] {return yytext[0];}
.	yyerror();

%%

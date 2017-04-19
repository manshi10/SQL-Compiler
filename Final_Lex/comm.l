%{
#include<stdio.h>
int flag=0;
int com=0;
%}
%%
"/*" {if(flag!=1){com++;} flag=1;}
"*/" {if(flag!=1){printf("%s",yytext);} else {flag=0;}}
--.*"\n" {if(flag==0){com++;}}
. {if(flag==0)printf("%s",yytext);}
%%
int yywrap(){
	return 1;
}
int main(){
	yylex();
	printf("#comments = %d\n ",com);
	return 0;
}

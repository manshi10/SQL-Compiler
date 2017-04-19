%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    
    int yydebug=1;
    
    /*Prototype Declarations*/
    int yylex();
    int yyerror();
    void display_ic();

    extern FILE *yyin;
    struct icg
    {
        char tabName[50];
        char cols[100];
        char refers[50];
    }icgTab[50];
       
    int icgIdx=0;
    char globTab[10];
    
%}
%start S
%union
{
    char var[10]; 
}
%token <var> CREATE DTYPE TABLENAME ID NUMBER REFS
%type <var> id

%%
S   : C1 ';' {printf("Accepted\n"); display_ic(); } '\n' S
    |
    ;

C1  : CREATE TABLENAME {strcpy(globTab, $2);} '(' COLDET ')'
    ;

COLDET  : COLDET ',' id data REFTAB
        | id data
        ;
REFTAB  : REFS TABLENAME {strcpy(icgTab[icgIdx-1].refers, $2);}
        |
        ;

data : DTYPE 
     ;

id  : ID {strcpy(icgTab[icgIdx].tabName, globTab); strcpy(icgTab[icgIdx++].cols, $1);}
    ;

%%
int main(int argc, char *argv[])
{
    //yyparse();
    int i=0;
    printf("Hello\n");
    yyin=fopen(argv[1],"r");
    yyparse(); 
    //display_symtab();
    //printf("After parse\n\n");
    //free(Sym);
    return 0;
}
void display_ic()
{
    int i;
    printf("The Intermediate Code Is:\n");
    printf("\n\n------------------------------------------------------------------\n");
    printf("%-25s %-25s %-25s \n", "TableName", "ColumnName","References");
    printf("------------------------------------------------------------------\n");
    for(i=0; i<icgIdx; i++)
        printf("%-25s %-25s %-25s\n",icgTab[i].tabName,icgTab[i].cols,icgTab[i].refers);
    printf("------------------------------------------------------------------\n\n");
}

int yyerror()
{
   // printf("\nError on line no:%d", LineNo);
    return 1;
}
    
int yywrap()
{
    return 1;
}  
                                            
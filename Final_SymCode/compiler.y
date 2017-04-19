%{
    #include<string.h>
    #include<stdio.h>
    #include<stdlib.h>
    
    int yydebug=1;
    int yylex();
    extern FILE *yyin;
    int yyerror();
    void make_symtab_entry(char[], char[]);
    void display_symtab();
    int search(char []); 
       
    struct Symboltable
    {
        char symname[50];
        char value[50];
    }Sym[200];
  
    int symcnt=0;
    
%}
%start S
%union
{
    char var[50]; 
}
%token <var> CREATE DTYPE TABLENAME ID NUMBER SELECT WHERE ORDER GROUP HAVING LE GE EQ NE LT GT
%token FROM DISTINCT ASC DESC OR AND UNION INTERSECT
%type <var> E F id TAB
%left AND OR
%left LT GT LE GE EQ NE
%%
S   : C1 ';' {printf("Accepted Create\n"); display_symtab(); } '\n' S
    | S0 ';' {printf("Accepted Select\n"); display_symtab(); } '\n' S
    |
    ;

C1  : CREATE {if(search($1)==-1) make_symtab_entry($1,"Creation");} TAB '(' COLDET ')'
    ;

TAB : TABLENAME {if(search($1)==-1) make_symtab_entry($1,"Table Name");} 
    ;
COLDET  : id data ',' COLDET
        | id data
        ;

data : DTYPE {if(search($1)==-1) make_symtab_entry($1,"Keyword");} 
     ;
S0  : S1 INTERSECT S1
    | S1 UNION S1
    | S1
    ;
S1  : SELECT {if(search($1)==-1) make_symtab_entry($1,"Selection Action");} attList FROM tabList S2 
    | SELECT {if(search($1)==-1) make_symtab_entry($1,"Selection Action");} DISTINCT attList FROM tabList S2
    ;

S2  : WHERE {if(search($1)==-1) make_symtab_entry($1,"Keyword");} C S3
    | S3
    ;

S3 : GROUP {if(search($1)==-1) make_symtab_entry($1,"Keyword");} attList S4
    | S4
    ;

S4 : HAVING {if(search($1)==-1) make_symtab_entry($1,"Keyword");} C S5
    | S5
    ;

S5 : ORDER {if(search($1)==-1) make_symtab_entry($1,"Keyword");} attList S6
    |
    ;

S6 : DESC
    | ASC
    |
    ;

attList : id ',' attList{
    if(search($1)==-1) make_symtab_entry($1,"Identifier");}
    | '*' {if(search("*")>0) make_symtab_entry("*","All");}
    | id
    ;

tabList : TABLENAME {if(search($1)==-1){printf("Cannot Select before Table Creation\n"); return -1;} } ',' tabList{
    if(search($1)==-1){printf("Cannot Select before Table Creation\n"); return -1;}}
    | TABLENAME  {if(search($1)==-1){printf("Cannot Select before Table Creation\n"); return -1;}}
    ;

C : C OR C
    | C AND C
    |E
    ;

E : F LT {if(search($2)==-1) make_symtab_entry($2,"Less Than");} F 
    | F GT {if(search($2)==-1) make_symtab_entry($2,"Greater Than");} F 
    | F LE {if(search($2)==-1) make_symtab_entry($2,"Less/Equal");} F 
    | F GE {if(search($2)==-1) make_symtab_entry($2,"Great/Equal");} F 
    | F EQ {if(search($2)==-1) make_symtab_entry($2,"Equal");} F 
    | F NE {if(search($2)==-1) make_symtab_entry($2,"Not Equal");} F 
    ;
F   : id
    | NUMBER {if(search($1)==-1) make_symtab_entry($1,"Numeric");}
    ;
id  : ID {if(search($1)==-1) make_symtab_entry($1,"Identifier");}
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
int search(char sym[10])
{
    int i,flag=0;
    for(i=0;i<20;i++)
    {
        if(strcmp(Sym[i].symname,sym)==0)
        {
            flag = 1;
            break;
        }
    }
    if(flag == 0)
        return -1;
    else
        return i;
}
void display_symtab()
{
    int i;
    printf("The Symbol Table\n");
    printf("\n\n---------------------------------\n");
    printf("%-25s %-25s\n", "Value", "Name");
    printf("---------------------------------\n");
    for(i=0; i<symcnt; i++)
        printf("%-25s %-25s\n",Sym[i].value,Sym[i].symname);
    printf("---------------------------------\n\n");
}
void make_symtab_entry(char n[], char val[])
{
    //printf("Came here%s %s\n",n,val);
    strcpy(Sym[symcnt].symname,n);
    strcpy(Sym[symcnt].value,val);
    symcnt++;
    return;
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

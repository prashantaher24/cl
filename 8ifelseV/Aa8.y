%{
#include<stdio.h>
int flag=0;
%}
%token IF E1 OPBR CLBR OPCB CLCB EQU RELOP NOT VAR CONST
%%
S: IF OPBR VAR RELOP CONST CLBR OPCB CLCB  
  E1 OPCB CLCB {printf("verifide");flag=1;} 
%%

int main()
{
yyparse();
return;
}

int yyerror()
{
if(flag==0)
printf("not verifide");
return;
}


/*
output:

user@user-Inspiron-3537:~/assign8$ lex A8.l
user@user-Inspiron-3537:~/assign8$ yacc -d Aa8.y
user@user-Inspiron-3537:~/assign8$ cc lex.yy.c y.tab.c
user@user-Inspiron-3537:~/assign8$ ./a.out
if(a>5) 

{

}

else

{

}
verifide



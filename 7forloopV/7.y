%{
#include<stdio.h>
#include<stdlib.h>
%}

%token FOR INT BREAK VAR NUM OPR


%%
E1: FOR '(' E ')' '{' E2 '}'  
;

E : INT VAR OPR NUM ';' VAR OPR NUM ';' VAR OPR 
 
| VAR OPR NUM ';' VAR OPR NUM ';' VAR OPR 
 
| VAR OPR NUM ';' VAR OPR VAR ';' VAR OPR 

;

E2: VAR OPR VAR E3  

|
|E1 E2 

;

E3: OPR VAR E3 

|';' E2 

;

%%

int main()
{
  

  yyparse();
   printf("\n\tValid For Loop Statements!!!\n" );  
  return 0;
}


//Input file   ip.txt
/*for(i=0;i<60;i++)
{
c=a+b-c;

d=e-f;

}*/

/* Output :
user@user-Inspiron-3537:~$ lex 7.l
user@user-Inspiron-3537:~$ yacc -d 7.y
user@user-Inspiron-3537:~$ cc lex.yy.c y.tab.c
y.tab.c: In function ‘yyparse’:
y.tab.c:1147:16: warning: implicit declaration of function ‘yylex’ [-Wimplicit-function-declaration]
       yychar = yylex ();
                ^~~~~
y.tab.c:1276:7: warning: implicit declaration of function ‘yyerror’ [-Wimplicit-function-declaration]
       yyerror (YY_("syntax error"));
       ^~~~~~~
user@user-Inspiron-3537:~$ ./a.out <ip.txt
for(i=0;i<60;i++)
{
c=a+b-c;

d=e-f;

}

	Valid For Loop Statements!!!
user@user-Inspiron-3537:~$ 
*/


//Input file   ip.txt
/*


if

*/

/*
Output:
user@user-Inspiron-3537:~$ lex 7.l
user@user-Inspiron-3537:~$ yacc -d 7.y
user@user-Inspiron-3537:~$ cc lex.yy.c y.tab.c
y.tab.c: In function ‘yyparse’:
y.tab.c:1147:16: warning: implicit declaration of function ‘yylex’ [-Wimplicit-function-declaration]
       yychar = yylex ();
                ^~~~~
y.tab.c:1276:7: warning: implicit declaration of function ‘yyerror’ [-Wimplicit-function-declaration]
       yyerror (YY_("syntax error"));
       ^~~~~~~
user@user-Inspiron-3537:~$ ./a.out <ip.txt
if
	syntax error
*/

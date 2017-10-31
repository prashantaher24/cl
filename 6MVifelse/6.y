%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
FILE *fo;
extern int line;
%}
%token MAIN VOID ELSE IF PRINTF VAR CONST INT CHAR ARGC ARGV
%%
e:VOID MAIN '(' e1 ')' '{' e4 '}' { fprintf(fo,"\nIf-Else is verified!\n");fprintf(fo,"\nTotal lines=%d",line); exit(0);}
;
e1:INT ARGC ',' CHAR '*' ARGV 
  |
  ;

e4:IF '(' VAR '>' VAR ')' '{' e5 '}' e6
  |
  ;
e5:PRINTF '(' '"' VAR '"' ')' ';'
  |
  ;
e6:ELSE '{' e5 '}'
 ;
%%

main()
{
fo=fopen("b.txt","w");
yyparse();
return(0);
}
int yyerror(const char *s)
{
printf("\n%s\n",s);
return 0;
}

//Input file        a.txt
/*
void main()
{
if(ab)
{
printf("a");
}
else
{
printf("b");
}
}
*/

/*Output:
user@user-Inspiron-3537:~$ ./a.out <a.txt
user@user-Inspiron-3537:~$ ./a.out <a.txt
user@user-Inspiron-3537:~$ lex 6.l
user@user-Inspiron-3537:~$ yacc 6.y
user@user-Inspiron-3537:~$ cc lex.yy.c y.tab.c 
y.tab.c: In function ‘yyparse’:
y.tab.c:1153:16: warning: implicit declaration of function ‘yylex’ [-Wimplicit-function-declaration]
       yychar = yylex ();
                ^~~~~
y.tab.c:1288:7: warning: implicit declaration of function ‘yyerror’ [-Wimplicit-function-declaration]
       yyerror (YY_("syntax error"));
       ^~~~~~~
6.y: At top level:
6.y:26:1: warning: return type defaults to ‘int’ [-Wimplicit-int]
 main()
 ^~~~
user@user-Inspiron-3537:~$ ./a.out <a.txt

syntax error


2nd output

//Input file        a.txt
/*
void main()
{
if(a<b)
{
printf("a");
}
else
{
printf("b");
}
}
*/

/*Output:
user@user-Inspiron-3537:~$ lex 6.l
user@user-Inspiron-3537:~$ yacc 6.y
user@user-Inspiron-3537:~$ cc lex.yy.c y.tab.c 
y.tab.c: In function ‘yyparse’:
y.tab.c:1153:16: warning: implicit declaration of function ‘yylex’ [-Wimplicit-function-declaration]
       yychar = yylex ();
                ^~~~~
y.tab.c:1288:7: warning: implicit declaration of function ‘yyerror’ [-Wimplicit-function-declaration]
       yyerror (YY_("syntax error"));
       ^~~~~~~
6.y: At top level:
6.y:26:1: warning: return type defaults to ‘int’ [-Wimplicit-int]
 main()
 ^~~~
user@user-Inspiron-3537:~$ ./a.out <a.txt
*/

/*   b.txt      (get created)

If-Else is verified!

Total lines=11
*/


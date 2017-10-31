Lex program

%{
#include "y.tab.h"
extern int yylval;
%}

%%
"#"     {return HASH;}
define  {return DEFINE;}
"<"     {return AS;}
"."     {return DOT;}
h       {return H;}
">"     {return AC;}
[a-z]+  {yylval = yytext[0]; return (FN);}
%%

int yywrap()
{
return 1;
}

Yacc program

%{
#include <stdio.h>
#include <stdlib.h>
%}
%token HASH DEFINE AS FN DOT H AC
%%
e:HASH DEFINE AS FN DOT H AC {printf(" this is valid");exit(0);}
;
%%
int main()
{
yyparse();
return 0;
}
int yyerror()
{
printf(" the error");
}

/*Output:
student@student-OptiPlex-3020:~$ lex 11.l
student@student-OptiPlex-3020:~$ bison -yd 11.y
student@student-OptiPlex-3020:~$ cc lex.yy.c y.tab.c
student@student-OptiPlex-3020:~$ ./a.out
#include<stdio.h>
the error
student@student-OptiPlex-3020:~$./a.out
#define<stdio.h>
this is valid
student@student-OptiPlex-3020:~$*/

%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include "y.tab.h"
int line=1,pos=0;
%}
%%
[\n] { line++; pos = 0; }
[\t ] {pos = pos + yyleng; }
[a-zA-Z]+ { strcpy(yylval.str,yytext); pos = pos + yyleng; return alpha; }
[0-9]+ { yylval.no = atoi(yytext); pos = pos + yyleng; return digit; }
. { pos = pos + yyleng; return yytext[0]; }
%%
int yywrap() { return 1; }\
void yyerror(char *s)
{
printf("\nERROR : %s at line %d:%d\n",s,line,pos);
}


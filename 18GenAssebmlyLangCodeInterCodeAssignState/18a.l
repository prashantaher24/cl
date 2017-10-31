%{
#include<stdio.h>
#include<string.h>
#include "y.tab.h"
%}

%%
[a-zA-Z][a-zA-Z0-9]*    {strcpy(yylval.var, yytext); return SYMBOL;}
[+]                     {strcpy(yylval.var, yytext); return PLUS;}
[-]                     {strcpy(yylval.var, yytext); return SUBTRACT;}
[*]                     {strcpy(yylval.var, yytext); return MULTIPLY;}
[/]                     {strcpy(yylval.var, yytext); return DIVIDE;}
[=]                     {strcpy(yylval.var, yytext); return EQUAL;}
[ \t]*                  {}
[\n]                    {return '\n';}
%%

int yywrap(void)
{
return 1;
}


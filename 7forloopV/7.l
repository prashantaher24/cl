%{
#include "y.tab.h"
#include<stdio.h>
%}

%%
[\n\t ]+ {printf("%s",yytext);}
"for" { printf("%s",yytext); return FOR;}
"int" { printf("%s",yytext); return INT;}
"break" { printf("%s",yytext); return BREAK; }
[a-zA-Z]+ { printf("%s",yytext); return VAR; }
[0-9]+ { printf("%s",yytext); return NUM; }
[<>=/+-/*//]+ { printf("%s",yytext); return OPR;}
. { printf("%s",yytext); return yytext[0]; }
%%

int yywrap()
{
  return 1;
}


void yyerror(const char *s)
{
  printf("\n\t%s",s);
  exit(0);
}


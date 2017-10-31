%{
#include "y.tab.h"
#include<string.h>
extern FILE *fin;
int line_no=1;
%}
%%
"\n" {line_no++;}
[\t]+ {}
[0-9]+ {yylval.no=atoi(yytext); return DIGIT;}
[a-z]+ {strcpy(yylval.str,yytext); return ID;}
. {return yytext[0];}
%%
void yyerror(const char *str)
{
printf("\n\t%s is at line %d for %s",str,line_no,yytext);
}
int yywrap()
{
return 1;
}


%{
#include"y.tab.h"
#include<string.h>
%}
%%
[0-9]+ {yylval.dval=atoi(yytext); return digit;}
[a-zA-Z]+ {strcpy(yylval.str,yytext); return id;}
. return yytext[0];
%%
int yywrap()
{
return 1;
}


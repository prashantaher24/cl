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


%{
#include "y.tab.h"
#include<string.h>
%}

%%

quit|QUIT       {exit(0);}
[a-zA-Z0-9]+    {strcpy(yylval.value, yytext); return SYMBOL;}
\n              {return 0;}
.               {return yytext[0];}
%%

int yywrap(void)
{
return 0;
}


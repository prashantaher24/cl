%{
#include"y.tab.h"
#include<stdio.h>
%}
%%
[\t\n ] ;
if {return IF;}
else {return ELSE;}
printf {return PRINTF;}
[a-zA-Z]+ {return VAR;}
[0-9]+ {return NUM;}
. {return yytext[0];}
%%
int yywrap()
{
return 1;
}





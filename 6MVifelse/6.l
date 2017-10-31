%{
#include "y.tab.h"
int line=1;
%}
%%
[\n] {line++;}
[\t ] {}
void {return VOID;}
if {return IF;}
else {return ELSE;}
main {return MAIN;}
argc {return ARGC;}
argv {return ARGV;}
printf {return PRINTF;}
int {return INT;}
char {return CHAR;}
[0-9]+ {return CONST;}
[a-z]+ {return VAR;}
. {return yytext[0];}

%%
int yywrap()
{
return 1;
}

%{
#include"y.tab.h"
%}
%%
if {return(IF);}
else {return(E1);}
"(" {return(OPBR);}
")" {return(CLBR);}
[a-zA-Z]+ {return(VAR);}
[0-9]+ {return(CONST);}
"=" {return(EQU);}
"<"|">" {return(RELOP);}
"!" {return(NOT);}
"{" {return(OPCB);}
"}" {return(CLCB);}
%%

int yywrap()
{
return 1;
}


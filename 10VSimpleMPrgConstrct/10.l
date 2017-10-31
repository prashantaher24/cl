%{
#include "y.tab.h"
%}
%%
main    {return MAIN;}
"("     {return OB;}
")"     {return CB;}
"{"     {return O;}
"}"     {return C;}
%%
int yywrap()
{
return 1;
}

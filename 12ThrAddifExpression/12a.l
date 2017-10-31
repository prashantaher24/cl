%{
#include "y.tab.h"
int lineno=1,flag=1;
extern FILE *fp;
%}
%%
"\n" {lineno++;}
[ \t]+ {}
[0-9]+ {yylval.no=atoi(yytext); return digit;}
"<=" |
">=" |
"<" |
">" |
"!=" |
"==" {if(flag==1) {printf("%s", yytext);} return rel_op;}
"{" {return opcrl;}
"}" {return clocrl;}
"(" {printf("("); return bracs_op;}
")" {printf(")"); flag=0; return bracs_cl;}
"if" {printf("if"); flag=1; return if_id;}
"else" {printf("else"); flag=1; return else_id;}
[a-z]+ { strcpy(yylval.str,yytext); if(flag==1) {printf("%s", yytext);} return id;}
"$"     {return(yytext[0]);}
.       { return(yytext[0]);}
%%
int yywrap()
{
return 1;
}

yyerror(char *s)
{
printf("%s at line no %d for %s ",s, lineno,yytext);
exit(1);
}


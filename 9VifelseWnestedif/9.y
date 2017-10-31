%{
#include<stdio.h>
%}
%token IF ELSE VAR NUM PRINTF
%%
E:IF'('VAR'>'VAR')''{'e2'}' ELSE'{'e2'}' {printf("IF-ELSE is VERIFIED");}
;
e2:E {printf("Inner");}
|PRINTF'(''"'VAR'"'')'';'
|
;
%%
int main()
{
yyparse();
return 0;
}
void yyerror(char *s)
{
printf("\nError %s",s);
}


/*
OutPut:
user@user-Inspiron-3537:~$ lex 9.l
user@user-Inspiron-3537:~$ bison -yd 9.y
user@user-Inspiron-3537:~$ cc lex.yy.c y.tab.c 
y.tab.c: In function ‘yyparse’:
y.tab.c:1130:16: warning: implicit declaration of function ‘yylex’ [-Wimplicit-function-declaration]
       yychar = yylex ();
                ^~~~~
y.tab.c:1271:7: warning: implicit declaration of function ‘yyerror’ [-Wimplicit-function-declaration]
       yyerror (YY_("syntax error"));
       ^~~~~~~
9.y: At top level:
9.y:18:6: warning: conflicting types for ‘yyerror’
 void yyerror(char *s)
      ^~~~~~~
y.tab.c:1271:7: note: previous implicit declaration of ‘yyerror’ was here
       yyerror (YY_("syntax error"));

user@user-Inspiron-3537:~$ ./a.out
if(a>b)
{
 if(a>B)
 {
   if(a>b)
   {
     printf("a");
   }
else
{
  printf("x");
}
IF-ELSE is VERIFIEDInner
}
else
{
  if(a>b)
  {
      printf("a");
  }
  else
  {
     printf("b");
  }
IF-ELSE is VERIFIEDInner}
IF-ELSE is VERIFIEDInner}
else
{
  printf("x");
}
IF-ELSE is VERIFIED^Z
[2]+  Stopped                 ./a.out
user@user-Inspiron-3537:~$ ./a.out
if(a>5) 

Error syntax erroruser@user-Inspiron-3537:~$ 


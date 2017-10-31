%{

#include <stdlib.h>
%}
%token MAIN OB CB O C 
%%
e:MAIN OB CB O C   {printf(" this is validated "); exit(0);}
;
%%
int main()
{
yyparse();
return 0;
}
 yyerror()
{
printf("this is error");
}


/* Output:
user@user-Inspiron-3537:~$ lex 10.l
user@user-Inspiron-3537:~$ yacc -d 10.y
user@user-Inspiron-3537:~$ cc lex.yy.c y.tab.c
y.tab.c: In function ‘yyparse’:
y.tab.c:1120:16: warning: implicit declaration of function ‘yylex’ [-Wimplicit-function-declaration]
       yychar = yylex ();
                ^~~~~
10.y:7:6: warning: implicit declaration of function ‘printf’ [-Wimplicit-function-declaration]
 e:MAIN OB CB O C   {printf(" this is validated "); exit(0);}
      ^~~~~~
10.y:7:6: warning: incompatible implicit declaration of built-in function ‘printf’
10.y:7:6: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’
y.tab.c:1255:7: warning: implicit declaration of function ‘yyerror’ [-Wimplicit-function-declaration]
       yyerror (YY_("syntax error"));
       ^~~~~~~
10.y: At top level:
10.y:15:2: warning: return type defaults to ‘int’ [-Wimplicit-int]
  yyerror()
  ^~~~~~~
10.y: In function ‘yyerror’:
10.y:17:1: warning: incompatible implicit declaration of built-in function ‘printf’
 printf("this is error");
 ^~~~~~
10.y:17:1: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’

user@user-Inspiron-3537:~$ ./a.out
void main() {}
void   this is validated 
user@user-Inspiron-3537:~$ ./a.out
void main{
void this is erroruser@user-Inspiron-3537:~$ 
*/


%{
#include<stdio.h>
#include<ctype.h>
#include<string.h>
extern FILE *yyin, *yyout;
%}
%union
{
char var[10];
}
%token<var> SYMBOL PLUS EQUAL MULTIPLY DIVIDE SUBTRACT%type<var> exp
%right EQUAL
%left PLUS SUBTRACT
%left MULTIPLY
%left DIVIDE
%%
input: line '\n' input
| '\n' input
| /*empty*/
;
line:
SYMBOL EQUAL exp        {fprintf(yyout, " MOV %s, AX\n", $1);}
|SYMBOL EQUAL SYMBOL    {fprintf(yyout, " MOV AX, %s \n MOV %s,AX\n",$3,$1);}
|SYMBOL EQUAL SUBTRACT SYMBOL {fprintf(yyout, " MOV AX, - %s \n MOV%s, AX\n",$4,$1);}
;

exp: SYMBOL PLUS SYMBOL         {fprintf(yyout, " MOV AX, %s \n ADD AX,%s\n",$1,$3);}
|SYMBOL SUBTRACT SYMBOL         {fprintf(yyout, " MOV AX, %s \n SUB AX,%s\n",$1,$3);}
|SYMBOL MULTIPLY SYMBOL         {fprintf(yyout, " MOV AX, %s \n MULAX, %s\n",$1,$3);}
|SYMBOL DIVIDE SYMBOL           {fprintf(yyout, " MOV AX, %s \n DIV AX,%s\n",$1,$3);}
;
%%

int yyerror(char *s)
{
printf("\n Error : %s", s);
}
int main(int argc, char *argv[])
{if(argc == 3)
{
yyin = fopen(argv[1], "r");
yyout = fopen(argv[2], "w");
}
else
{
printf("Usage : ./a.out file1 file2");
exit(1);
}
yyparse();
printf("\n Output File Generated : %s\n\n", argv[2]);
return 1;
}

/*.....................input3.txt................
temp1 = a * b
temp2 = temp3 / c
temp3 = temp2 + d
temp4 = e - temp3
temp5 = - temp4
f = temp5
*/

/*Output: student@student-OptiPlex-3020:~$ lex 18a.l
student@student-OptiPlex-3020:~$ yacc -d 18b.y
student@student-OptiPlex-3020:~$ gcc lex.yy.c y.tab.c 
18b.y: In function ‘main’:
18b.y:47:1: warning: incompatible implicit declaration of built-in function ‘exit’ [enabled by default]
 exit(1);
 ^
student@student-OptiPlex-3020:~$ ./a.out input3.txt output.txt

 Output File Generated : output.txt

student@student-OptiPlex-3020:~$ 


..........output.txt............

MOV AX, a 
 MULAX, b
 MOV temp1, AX
 MOV AX, temp3 
 DIV AX,c
 MOV temp2, AX
 MOV AX, temp2 
 ADD AX,d
 MOV temp3, AX
 MOV AX, e 
 SUB AX,temp3
 MOV temp4, AX
 MOV AX, - temp4 
 MOVtemp5, AX
 MOV AX, temp5 
 MOV f,AX
 */


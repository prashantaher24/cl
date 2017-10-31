%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
struct icode
{
char opr,op1[33],op2[33],res[33];
}ic[50];
int icnt=0,temp=0;
void disp();
void emit(char ,char [], char [], char []);void codeopt();
%}
%union {char str[33]; int no; };
%token <str> alpha
%token <no> digit
%type <str> E
%type <str> E1
%left '+' '-'
%left '*' '/'
%nonassoc '='
%%
E1: '$' {
printf("\n\t\t Intermediate Code \n");
printf("------------------------------------------------------------------");
disp();
codeopt();
printf("\n\t\t Optimized Intermediate Code \n");
printf("------------------------------------------------------------------");
disp();
icnt = 0;temp = 0;
yyparse();
}
| alpha '=' E ';' { emit('=',$3,"",$1); yyparse(); }
;
E: E '+' E { sprintf($$,"t%d",temp++); emit('+',$1,$3,$$); }
| E '-' E { sprintf($$,"t%d",temp++); emit('-',$1,$3,$$); }
| E '*' E { sprintf($$,"t%d",temp++); emit('*',$1,$3,$$); }
| E '/' E { sprintf($$,"t%d",temp++); emit('/',$1,$3,$$); }
| '-' E { sprintf($$,"t%d",temp++); emit('-',$2,"",$$); }
| alpha {}
| digit { sprintf($$,"%d",$1); }
;
%%
void disp()
{int i;
printf("\n\nOperator \tOperand 1 \tOperand 2\tResult\n");
for(i=0;i<icnt;i++)
printf("%c \t\t%s \t\t%s \t\t%s\n",ic[i].opr,ic[i].op1,ic[i].op2,ic[i].res);
}
void emit(char opr,char op1[33],char op2[33],char res[33])
{
ic[icnt].opr = opr;
strcpy(ic[icnt].op1,op1);
strcpy(ic[icnt].op2,op2);
strcpy(ic[icnt++].res,res);
}
void codeopt()
{
int i,j;
for(i = 1;i<icnt;i++)
{
if(ic[i].opr == '=' && (!strcmp(ic[i].op1,ic[i-1].res) || !strcmp(ic[i].op2,ic[i-
1].res)))
{
strcpy(ic[i-1].res,ic[i].res);
for(j=i;j<icnt-1;j++)
{
ic[j].opr = ic[j+1].opr;
strcpy(ic[j].op1,ic[j+1].op1);
strcpy(ic[j].op2,ic[j+1].op2);
strcpy(ic[j].res,ic[j+1].res);
}
i--;
icnt--;
}
}
}
int main()
{
yyparse();
return 0;}


/*Output:
student@student-OptiPlex-3020:~$ lex 13a.l
student@student-OptiPlex-3020:~$ bison -yd 13b.y
student@student-OptiPlex-3020:~$ gcc lex.yy.c y.tab.c
student@student-OptiPlex-3020:~$ ./a.out
a=a+b/c-d
;$

		 Intermediate Code 
------------------------------------------------------------------

Operator 	Operand 1 	Operand 2	Result
/ 		b 		c 		t0
+ 		a 		t0 		t1
- 		t1 		d 		t2
= 		t2 		 		a

		 Optimized Intermediate Code 
------------------------------------------------------------------

Operator 	Operand 1 	Operand 2	Result
/ 		b 		c 		t0
+ 		a 		t0 		t1
- 		t1 		d 		a
*/

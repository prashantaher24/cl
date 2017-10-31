%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
char* addtotable(char *op1, char *op2, char* op);
int sindex = 0, optsindex = 0, repindex = 0;
int found = 0;
char temp[10] = "temp1";
struct T
{
char operand1[10];
char operator[4];
char operand2[10];
char tempvar[10];
}code[30], optcode[20];
struct tempreptable
{
char orig[10];
char replace[10];}rep[10];
%}

%union
{
char value[10];
}
%token <value> SYMBOL
%type <value> expr stmt

%left '-' '+'
%left '*'
%left '/'
%right '^'
%nonassoc UMINUS

%%
stmt : SYMBOL '=' expr  {strcpy($$, addtotable($1, $3, "=")); temp[4] ++;}
        |expr           {printf("%s", $1);}
        ;
expr : expr '+' expr {
                        if(strcmp($1, "0") != 0 && strcmp($3, "0") != 0)
                        {
                                strcpy($$, addtotable($1, $3, "+"));
                                temp[4] ++;
                        }
                        if(strcmp($1, "0") == 0 && strcmp($3, "0") != 0)
                        {
                                strcpy($$, addtotable($3, "", ""));
                                temp[4] ++;
                        }
                        if(strcmp($1, "0") != 0 && strcmp($3, "0") == 0)
                        {
                                strcpy($$, addtotable($1, "", ""));
                                temp[4] ++;
                         }
                      }
|expr '-' expr  {
                        if(strcmp($3, "0") != 0)
                        {
                                strcpy($$, addtotable($1, $3, "-"));
                                temp[4] ++;
                        }
                        else
                        {
                                strcpy($$, addtotable($1, "", ""));
                                temp[4] ++;
                        }
                 }
|expr '*' expr {
if(strcmp($1, "0") == 0 || strcmp($3, "0") == 0)
{
strcpy($$, addtotable("0", "", ""));
}
else
{
if(strcmp($1, "1") != 0 && strcmp($3, "1") != 0)
{
strcpy($$, addtotable($1, $3, "*"));
temp[4] ++;
}
if(strcmp($1, "1") == 0)
{
strcpy($$, addtotable($3, "", ""));
temp[4] ++;
}
if(strcmp($3, "1") == 0)
{
strcpy($$, addtotable($1, "", ""));
temp[4] ++;
}
}
}|expr '/' expr
{
if(strcmp($3, "1") != 0 && strcmp($1, "0") != 0)
{
strcpy($$, addtotable($1, $3, "/"));
temp[4] ++;
}
if(strcmp($3, "1") == 0)
{
strcpy($$, addtotable($1, "", ""));
temp[4] ++;
}
if(strcmp($1, "0") == 0)
{
addtotable("0", "", "");
}
if(strcmp($3, "0") == 0)
{
printf("\n Error : Divide by Zero.");
}
}
|SYMBOL
{strcpy($$, $1);}
|'('expr')'
{strcpy($$, $2);}
|'-'expr %prec UMINUS {strcpy($$, addtotable("", $2, "-")); temp[4] ++;}
;
%%
char* addtotable(char *op1, char *op2, char* op)
{
strcpy(code[sindex].operand1, op1);
strcpy(code[sindex].operand2, op2);
strcpy(code[sindex].operator, op);
strcpy(code[sindex].tempvar, temp);
sindex ++;
return temp;
}void optimizetable()
{
int i, j;
for(i = 0; i < sindex; i ++)
{
found = 0;
for(j = 0; j < optsindex; j ++)
{
if(strcmp(code[i].operand1,
optcode[j].operand1)
==
0
&&
strcmp(code[i].operator, optcode[j].operator) == 0 && strcmp(code[i].operand2,
optcode[j].operand2) == 0)
{
strcpy(rep[repindex].orig, code[i].tempvar);
strcpy(rep[repindex].replace, optcode[j].tempvar);
repindex ++;
found = 1;
}
if(strcmp(code[i].operator, "+") == 0 || strcmp(code[i].operator, "*") == 0)
{
if(strcmp(code[i].operand1, optcode[j].operand2) == 0 &&
strcmp(code[i].operand2, optcode[j].operand1) == 0)
{
strcpy(rep[repindex].orig, code[i].tempvar);
strcpy(rep[repindex].replace, optcode[j].tempvar);
repindex ++;
found = 1;
}
}
}
if(found == 0)
{
optcode[optsindex ++] = code[i];
}
}
for(i = 0; i < optsindex; i ++)
{
for(j = 0; j < repindex; j ++)
{
if(strcmp(optcode[i].operand1, rep[j].orig) == 0)strcpy(optcode[i].operand1, rep[j].replace);
if(strcmp(optcode[i].operand2, rep[j].orig) == 0)
strcpy(optcode[i].operand2, rep[j].replace);
}
}
}
void display()
{
int i;
printf("\n\n Intermediate Code : ");
for(i = 0; i < sindex - 1; i ++)
{
printf("\n %s = %s %s %s", code[i].tempvar, code[i].operand1, code[i].operator,
code[i].operand2);
}
printf("\n %s = %s ", code[i].operand1, code[i-1].tempvar);
printf("\n\n Optimized Code : ");
for(i = 0; i < optsindex; i ++)
{
if(strcmp(optcode[i].operator, "=") == 0)
printf("\n %s = %s ", optcode[i].operand1, optcode[i-1].tempvar);
else
printf("\n %s = %s %s %s", optcode[i].tempvar, optcode[i].operand1,
optcode[i].operator, optcode[i].operand2);
}
printf("\n\n Replace Table For Optimized Table:\n Original\tReplace");
for(i = 0; i < repindex; i ++)
printf("\n %s\t\t%s", rep[i].orig, rep[i].replace);
}
extern FILE *yyin;
int main(void)
{
printf("\n Type quit to exit.\n\n");
do
{
sindex = 0;optsindex = 0;
repindex = 0;
temp[4] = '1';
printf("\n\n\n Enter Expression : ");
yyparse();
optimizetable();
display();
}while(!feof(yyin));
return 0;
}
int yyerror(char *s)
{
printf("\n %s.\n", s);
}


/*output:
student@student-OptiPlex-3020:~$ lex 17a.l
student@student-OptiPlex-3020:~$ yacc -d 17b.y
student@student-OptiPlex-3020:~$ gcc lex.yy.c y.tab.c 
student@student-OptiPlex-3020:~$ ./a.out

 Type quit to exit.




 Enter Expression : x=(a+b)*(a+b)


 Intermediate Code : 
 temp1 = a + b
 temp2 = a + b
 temp3 = temp1 * temp2
 x = temp3 

 Optimized Code : 
 temp1 = a + b
 temp3 = temp1 * temp1
 x = temp3 

 Replace Table For Optimized Table:
 Original	Replace
 temp2		temp1


 Enter Expression : quit
student@student-OptiPlex-3020:~$ */

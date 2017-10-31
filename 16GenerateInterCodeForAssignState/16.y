%{
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	char* addtotable(char *op1, char *op2, char* op);
	int sindex = 0;
	char temp[10] = "temp1";
	struct T
	{
		char operand1[10];
		char operator[4];
		char operand2[10];
		char tempvar[10];
	}code[50];	
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
stmt :	SYMBOL '=' expr	{strcpy($$, addtotable($1, $3, "=")); 	temp[4] ++;}
	|expr		{printf("%s", $1);}
	;

expr :	expr '+' expr	{strcpy($$, addtotable($1, $3, "+"));	temp[4] ++;}
	|expr '-' expr	{strcpy($$, addtotable($1, $3, "-"));	temp[4] ++;}
	|expr '*' expr	{strcpy($$, addtotable($1, $3, "*"));	temp[4] ++;}
	|expr '/' expr	{strcpy($$, addtotable($1, $3, "/"));	temp[4] ++;}
	|SYMBOL		{strcpy($$, $1);}
	|'('expr')'	{strcpy($$, $2);}
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
}
void display()
{
	int i;
	for(i = 0; i < sindex; i  ++)
	{
		if(strcmp(code[i].operator, "=") != 0)
			printf("\n %s = %s %s %s", code[i].tempvar, code[i].operand1, code[i].operator, code[i].operand2);
		else
			printf("\n %s = %s ", code[i].operand1, code[i-1].tempvar);
	}
}

extern FILE *yyin;
int main(void)
{
	printf("\n Type quit to exit.\n\n");
	do
	{
		printf("\n Enter Expression : ");
		yyparse();
		display();
		printf("\n\n");
	}while(!feof(yyin));

	return 0;
}

int yyerror(char *s)
{
	printf("\n %s.\n", s);
}


/*Output:
user@user-Inspiron-3537:~$ lex 16.l
user@user-Inspiron-3537:~$ bison -yd 16.y
user@user-Inspiron-3537:~$ gcc lex.yy.c y.tab.c -ll
user@user-Inspiron-3537:~$ ./a.out

 Type quit to exit.


 Enter Expression : c=-4+2/3+(2*6)  

 temp1 =  - 4
 temp2 = 2 / 3
 temp3 = temp1 + temp2
 temp4 = 2 * 6
 temp5 = temp3 + temp4
 c = temp5 


 Enter Expression : quit
user@user-Inspiron-3537:~$ 

*/

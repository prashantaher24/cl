%{

#include<stdio.h>
int flag=0;
char c;

%}

%%

(""[aA][nN][dD]"")|(""[oO][rR]"")|(""[bB][uU][tT]"") {flag=1;} 
.|[\n] 

%%

int yywrap()
{
	return 1;
}

int main()
{
	do
	{
		printf("Please enter a sentence: ");
		yylex();	
		if(flag==1) 
		{
			printf("Entered sentence is a compound sentence.\n");
			flag = 0;
		}
		else 
			printf("Entered sentence is a simple sentence.\n");
		printf("Do you want to continue(y/n)?: ");
		scanf("%c",&c);	
	}while(c=='y');
	return 0;
}


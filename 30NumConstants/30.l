%{

#include<stdio.h>
int c = 0;

%}

space " "

%%

#define{space}[a-zA-Z]*[0-9]* {c++;}
#DEFINE{space}[a-zA-Z]*[0-9]* {c++;}
"int"  |
"float" |
"double" |
"void" |
"char" {
 char ch;
 ch=input();
 while(1) {
   if(ch==',') 
      c++;
   if(ch==';'){
      c++;
      break;
   }
   if(ch=='(')
	break;
   if(ch=='\n')
      break;
   ch=input();
  }
}
.|[\n]

%%

int yywrap()
{
       return 1;
} 

int main()
{
	FILE *fp;
      	fp=fopen("30.c","r");
      	if(fp==NULL)
      	{
       		printf("\nSorry! But this file can't be opened!");
      	}
      	else
      	{
		yyin=fp;
                yylex();
      	}
	printf("Given file contains: ");
     	printf("\nNumber of constants are %d.\n",c); 
}


/* Output :
user@user-Inspiron-3537:~$ lex 30.l
user@user-Inspiron-3537:~$ cc lex.yy.c
user@user-Inspiron-3537:~$ ./a.out
Given file contains: 
Number of constants are 5.
user@user-Inspiron-3537:~$ 
*/

%{

#include<stdio.h>
int c = 0;

%}

%%

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
      	fp=fopen("28.c","r");
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
     	printf("\nNumber of identifiers are %d.\n",c); 
}


/*Output:
user@user-Inspiron-3537:~$ lex 28.l
user@user-Inspiron-3537:~$ cc lex.yy.c
user@user-Inspiron-3537:~$ ./a.out
Given file contains: 
Number of identifiers are 4.
user@user-Inspiron-3537:~$ 
*/

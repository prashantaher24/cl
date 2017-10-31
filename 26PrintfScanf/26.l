%{

#include<stdio.h>
int yylex(void);
int p=0,s=0;

%}

%%

"printf" {p++;}
"scanf" {s++;}
[^printf] /* Ignore everything except printf */
[^scanf] /* Ignore everything except scanf */
n 

%%

int yywrap()
{
       return 1;
} 

int main()
{
	FILE *fp;
      	fp=fopen("26.c","r");
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
     	printf("\nNumber of printf statements are %d.\n",p); 
     	printf("\nNumber of scanf statements are %d.\n",s); 
}


/*Output:
user@user-Inspiron-3537:~$ lex 26.l
user@user-Inspiron-3537:~$ cc lex.yy.c
user@user-Inspiron-3537:~$ ./a.out
Given file contains: 
Number of printf statements are 6.

Number of scanf statements are 2.
user@user-Inspiron-3537:~$ 
*/

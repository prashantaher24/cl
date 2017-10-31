%{

#include<stdio.h>
int yylex(void);
int c=0,w=0,s=0,l=0;

%}

%%

" " {c++;s++;}
[\n] {c++;l++;}
[^ \n\t]+ {w++;c+=yyleng;}

%%

int yywrap()
{
       return 1;
} 

int main()
{
	FILE *fp;
      	fp=fopen("33.txt","r");
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
     	printf("\nNumber of characters are %d.\n",c); 
     	printf("\nNumber of words are %d.\n",w); 
     	printf("\nNumber of blank spaces are %d.\n",s); 
     	printf("\nNumber of lines are %d.\n",l); 
}


/*Output:user@user-Inspiron-3537:~$ lex 33.l
user@user-Inspiron-3537:~$ cc lex.yy.c
user@user-Inspiron-3537:~$ ./a.out
Given file contains: 
Number of characters are 1512.

Number of words are 275.

Number of blank spaces are 240.

Number of lines are 35.
user@user-Inspiron-3537:~$ 


*/

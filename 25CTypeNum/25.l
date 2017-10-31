%{

#include<stdio.h>
int yylex(void);
int pi=0,ni=0,pf=0,nf=0;

%}

digit [0-9]+

%%

[+]?[0-9]+ {pi++;} /* ?: 0 or 1 copy of preceding expression */
[-][0-9]+ {ni++;} /* +: 1 or more copies of preceding expression */
[+]?[0-9]*\.[0-9]+ {pf++;}/* *: 0 or more copies of preceding expression */
[-][0-9]*\.[0-9]+ {nf++;}
\n /* Ignore next lines */
[ \t]+ /* Ignore white spaces */
[,]+ /* Ignore ,*/

%%

int yywrap()
{
       return 1;
} 

int main()
{
	FILE *fp;
      	fp=fopen("25.txt","r");
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
     	printf("\nNumber of positive integers are %d.\n",pi); 
     	printf("\nNumber of negative integers are %d.\n",ni); 
     	printf("\nNumber of positive fractions are %d.\n",pf); 
     	printf("\nNumber of negative fractions are %d.\n",nf); 
}







/* Output :
user@user-Inspiron-3537:~$ lex 25.l
user@user-Inspiron-3537:~$ cc lex.yy.c
user@user-Inspiron-3537:~$ ./a.out
Given file contains: 
Number of positive integers are 9.

Number of negative integers are 6.

Number of positive fractions are 3.

Number of negative fractions are 2.
user@user-Inspiron-3537:~$ 
*/



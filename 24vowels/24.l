%{

#include<stdio.h>
int yylex(void);
int c=0,v=0,i=0,s=0,d=0;

%}

digit [0-9]+

%%

[aeiouAEIOU] {v++;}
[a-zA-Z] {c++;}
{digit} {d++;i+=yyleng;}
[!@#$%^<>&*()-+] {s++;}
\n /* Ignore next lines */
[ \t]+ /* Ignore white spaces */

%%

int yywrap()
{
       return 1;
} 

int main()
{
	FILE *fp;
      	fp=fopen("24.txt","r");
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
     	printf("\nNumber of vowels are %d.",v);
     	printf("\nNumber of consonants are %d.",c);
     	printf("\nNumber of digits are %d.", d);
     	printf("\nNumber of special characters are %d.",s);
     	printf("\nNumber of positive integers are %d.\n",i);   
}

//******24.txt******//
vaishnavi nalkande
dipali amale
1244444444


/*Output:
user@user-Inspiron-3537:~$ lex 24.l
user@user-Inspiron-3537:~$ cc lex.yy.c
user@user-Inspiron-3537:~$ ./a.out
Given file contains: 
Number of vowels are 13.
Number of consonants are 15.
Number of digits are 1.
Number of special characters are 0.
Number of positive integers are 10.
user@user-Inspiron-3537:~$ 
*/

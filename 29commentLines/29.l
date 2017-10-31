%option noyywrap

%{
	#include<stdio.h>
	int num_comments,num_commentLines,flag=0,num_codeLines=0,num_blankLines=0;
%}

%x comment

%%

[ ]				{}
.+"//".*"\n"			{num_comments++; num_commentLines++;num_codeLines++;}
"//".*"\n"			{num_comments++; num_commentLines++;}
.+"/*"				{num_codeLines++;BEGIN comment;}
"/*"				{BEGIN comment;}
^[ ]*\n				{num_blankLines++;num_codeLines++;}
.				{}
\n				{num_codeLines++;}
<comment>.			{}
<comment>\n			{num_commentLines++;}
<comment>.\n			{num_commentLines++;}
<comment>"*/".+\n		{num_comments++; num_commentLines++; num_codeLines++; BEGIN 0;}
<comment>"*/"\n			{num_comments++; num_commentLines++;num_codeLines++; BEGIN 0;}

%%

int main()
{
	FILE *fp;
      	fp=fopen("29.c","r");
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
     	printf("\nNumber of comments are %d.",num_comments);
     	printf("\nNumber of conmment lines are %d.",num_commentLines);
     	printf("\nNumber of code lines are %d.", num_codeLines);
     	printf("\nNumber of blank lines are %d.\n",num_blankLines);  
}

/*Output:

user@user-Inspiron-3537:~$ lex 29.l
user@user-Inspiron-3537:~$ cc lex.yy.c
user@user-Inspiron-3537:~$ ./a.out
Given file contains: 
Number of comments are 6.
Number of conmment lines are 8.
Number of code lines are 17.
Number of blank lines are 1.
user@user-Inspiron-3537:~$ 
*/

%{
#include<stdio.h>
%}

arithmetic [+|-|*|/]
conditional [?:]
digit [0-9]
delimiter [{|}|(|)|;|,|:|"]
equality [==|!=]
header <stdio.h>|<conio.h>
letter [A-Za-z]
logical ["&&"|"||"]
preprocessor #include|#pragma 
relational [<|>|<=|>=|<>]
unary [++|\-\-|sizeof|!|~]
underscore [_]
tab [\t]
nextline [\n]

%%

{header} {printf("%s is an header file.\n",yytext);}
int|float|double|char|void {printf("%s is a data type.\n",yytext);}
if|else|do|while|case|switch|break|default|printf|scanf|return|main {printf("%s is a keyword.\n",yytext);}
"=" {printf("%s is an assignment operator.\n",yytext);}
"%c"|"%d"|"%f"|"%s" {printf("%s is a format specifier.\n",yytext);} 
{letter}({letter}|{digit}|{underscore})* {printf("%s is an identifier.\n",yytext);}
&{letter}({letter}|{digit}|{underscore})* {printf("%s is a reference address.\n",yytext);}
{digit}+ {printf("%s is a digit.\n",yytext);}
{arithmetic} {printf("%s is an arithmetic operator.\n",yytext);}
{delimiter} {printf("%s is a delimiter.\n",yytext);} 
{conditional} {printf("%s is a conditional operator.\n",yytext);}
{equality} {printf("%s is an equality operator.\n",yytext);}
{preprocessor} {printf("%s is a preprocessor.\n",yytext);}
{relational} {printf("%s is a relational operator.\n",yytext);}
{unary}	{printf("%s is an unary operator.\n",yytext);}
{tab} {printf("\\t is an escape sequence.\n");}
{nextline} {printf("\\n is an escape sequence.\n");}
\"({letter}|{digit}|{underscore}|{tab}|{nextline})*\" {printf("%s is a string literal.\n",yytext);}

%%

int yywrap()
{
	return 1;
}

int main(int argc, char* argv[])
{
	FILE *fp;
	fp = fopen("34.c","r");
	yyin = fp;
	yylex();
	return 0;
}

/*Output:
user@user-Inspiron-3537:~$ lex 34.l
user@user-Inspiron-3537:~$ cc lex.yy.c
user@user-Inspiron-3537:~$ ./a.out
#include is a preprocessor.
<stdio.h> is an header file.
\n is an escape sequence.
void is a data type.
 main is a keyword.
( is a delimiter.
) is a delimiter.
\n is an escape sequence.
{ is a delimiter.
\n is an escape sequence.
\t is an escape sequence.
int is a data type.
 a is an identifier.
 = is an assignment operator.
 0 is a digit.
, is a delimiter.
 b is an identifier.
 = is an assignment operator.
 0 is a digit.
, is a delimiter.
 c is an identifier.
 = is an assignment operator.
 0 is a digit.
; is a delimiter.
\n is an escape sequence.
\t is an escape sequence.
scanf is a keyword.
( is a delimiter.
" is a delimiter.
%d is a format specifier.
%d is a format specifier.
" is a delimiter.
, is a delimiter.
&a is a reference address.
, is a delimiter.
&b is a reference address.
) is a delimiter.
; is a delimiter.
\n is an escape sequence.
\t is an escape sequence.
c is an identifier.
 = is an assignment operator.
 a is an identifier.
 + is an arithmetic operator.
 b is an identifier.
; is a delimiter.
\n is an escape sequence.
\t is an escape sequence.
printf is a keyword.
( is a delimiter.
c is an identifier.
) is a delimiter.
; is a delimiter.
\n is an escape sequence.
} is a delimiter.
\n is an escape sequence.
user@user-Inspiron-3537:~$ */

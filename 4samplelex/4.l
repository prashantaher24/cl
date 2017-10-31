%{
#include<stdio.h>
%}

fpoint [0-9]+-[0-9]+

delimit [ \t\n]

letter [a-zA-Z]+

intconst [0-9]+

us [_] 

%%
int |char | double | float {printf("\n\t %s is a data type", yytext);}
if | static | void | for | do | while | switch | printf | getch | stdio | include | main {printf ("\n\t%s is a keyword", yytext);}
"+" | "-" | "*" | "%" | "/" {printf ("\n\t %s is an arithcmatic operator",yytext);}
"&" | "|" {printf ("\n\t%s is Bitwise operator",yytext);}
"&&" | "||" {printf ("\n\t%s is Logical operator", yytext);}
"=" {printf ("\n\t %s is assignment operator ",yytext);}
">>" | "<<" {printf("\n\t%s is shift operator",yytext);}
"<" | ">" | "<=" | ">=" { printf ("\n\t%s is Relational operator",yytext); }
":" | ";" | "," {printf ("\n\t%s is a terminator",yytext);}
"#" | "." | "$" | "(" | ")" | "{" | "}" | "@" | "\"" {printf ("\n \t%s is a special symbol",yytext);}
"\\n" | "\\t" {printf ("\n\t %s is the escape sequence",yytext);}
{intconst} {printf ("\n\t%s is integer constant", yytext);}
{fpoint} {printf ("\n \t%s is floating point number",yytext);}
{delimit} {printf ("\n\t%s is delimiter",yytext);}
{letter}({intconst}|{letter}|{us})* {printf("\n\t %s is identifier",yytext);}
{intconst}({letter})* {printf("\n\t%s is Invalid token", yytext);}
%%

int main()
{
FILE *fp;
fp=fopen("lex.txt","r");
if(fp==NULL){
 printf("\n\t cannot open file");
}
else {
yyin=fp;
yylex();
}
fclose(fp);
return 1;
}

int yywrap()
{
return 1;
}


//Input file: lex.txt
c=a+b


/* Output: @student-OptiPlex-3020:~$ lex 4.l
student@student-OptiPlex-3020:~$ cc lex.yy.c 
student@student-OptiPlex-3020:~$ ./a.out

	 c is identifier
	 = is assignment operator 
	 a is identifier
	 + is assignment operator 
	 b is identifier
	
 is delimiterstudent@student-OptiPlex-3020:~$ */







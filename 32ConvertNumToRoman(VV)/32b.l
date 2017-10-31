%{

	#include<stdio.h>
	int add=0;
	int invalid=0;

%}


%%

I add=add+1;
V add=add+5;
X add=add+10;
L add=add+50;
C add=add+100;
D add=add+500;
M add=add+1000;
IV add=add+4;
IX add=add+9;
XL add=add+40;
VL add=add+45;
IVL add=add+44;
IL add=add+49;
VC add=add+95;
XC add=add+90;
IC add=add+99;
IVC add=add+96;
XD add=add+490;
ID add=add+499;
VD add=add+495;
CD add=add+400;
LD add=add+450;
CM add=add+900;
IM add=add+999;
LM add=add+950;
XM add=add+990;
VM add=add+995;
IVD add=add+496;

IXI|IVI|VIV|LC|DM|IVX|VX|LXV|DM {invalid=1;}

[\n] {
	if(invalid==1)
	{
		printf("\nSorry! You must have entered invalid input. Please enter a valid roman number.\n");
	}
	else
	{
		printf("\nEntered input is a valid roman number...\n");
		printf("\nDecimal equivalent of entered roman number: %d\n\n",add);
	}

     }

%%

int main()
{	
	printf("\nPlease enter a roman number(Valid digits are I, V, X, L, C, D, M): ");	
	yylex();
	return 0;
}

int yywrap()
{
	return 1;
}

/*Output:
user@user-Inspiron-3537:~$ lex 32b.l
user@user-Inspiron-3537:~$ cc lex.yy.c
user@user-Inspiron-3537:~$ ./a.out

Please enter a roman number(Valid digits are I, V, X, L, C, D, M): XX

Entered input is a valid roman number...

Decimal equivalent of entered roman number: 20

^Z
[8]+  Stopped                 ./a.out
user@user-Inspiron-3537:~$ ./a.out

Please enter a roman number(Valid digits are I, V, X, L, C, D, M): IXI

Sorry! You must have entered invalid input. Please enter a valid roman number.

*/

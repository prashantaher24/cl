#include<stdio.h> 
#include<conio.h>
/* #include: preprocessor directive
   stdio.h: standard input-output; header file
*/

void main() //executiion starts
{
	int a = 0, b = 0, c = 0; 	
	/* initialization is done here */
	scanf("%d%d",&a,&b);
	//taking input from user
	c = a + b;
	/*  assigning value to c */
	printf(c);
	//finally, printing the result
}

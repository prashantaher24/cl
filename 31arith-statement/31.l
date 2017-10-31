%option noyywrap

%{

#include<stdio.h>
int op=0,s=0,b=0,f=0,l=0,m=0,k=0,pf=0,mf=0,sf=0,df=0,flag=0,bf=0,top=-1,ef=0;
char a[100];
char ch;

%}

%%

([0-9]+)([a-zA-Z]+) {l=l+2; /*printf("* \n");*/ op++;}
([a-zA-Z]+)([0-9]+) {l=l+2; /*printf("* \n");*/ op++;}
[0-9a-zA-Z]+ {m=m+1;}
[+] {/*printf("+ \n");*/if(pf==0){op++;pf=1;}}
[-] {/*printf("- \n");*/if(mf==0){op++;mf=1;}}
[*] {/*printf("* \n");*/if(sf==0){op++;sf=1;}}
[/] {/*printf("/ \n");*/if(pf==0){op++;df=1;}}
[=] {flag=1; ef++; printf("= found");}
[(] {b++;bf=1;}
[)] {b--;if(bf!=1)b=555;}
[\[] {s++;bf=1;}
[]] {s--;if(bf!=1)b=555;}
[{] {f++;bf=1;}
[}] {f--;if(bf!=1)b=555;}
.|[\n]

%%

void main()
{
	do
	{	
		printf("Please enter an arithmetic expression: \n ");
		yylex();
		if((b==0)&&(s==0)&&(f==0)&&(op>=1)&&(top==-1))
		{
			if(flag==1)
	         	{
				if(ef==1)
	           			printf("It is an equation. \n");
				else
	           			printf("It is an invalid equiation \n");
			}
			else
	         	{ 
				printf("It is a valid arithmetic expression. \n");
		        }
		}
		else
		{
			printf("It is an invalid arithmetic expression.\n");
	 	}
		printf("\nDo you want to continue(y/n)?: ");
		scanf("%c",&ch);
		if(ch=='y')
		{			op=0;s=0;b=0;f=0;l=0;m=0;k=0;pf=0;mf=0;sf=0;df=0;flag=0;bf=0;top=-1;ef=0;
		}
	}while(ch=='y');
}

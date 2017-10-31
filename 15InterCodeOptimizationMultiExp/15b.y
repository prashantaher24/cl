%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
struct code
{
char opr;
char opd1[20],opd2[20],res[20];
}ic[20];
int icc=0,temp=1;
FILE *fp=NULL;
%}
%union
{
char str[20];
int dval;
}
%token <dval> digit
%token <str> id
%left '+' '-'
%left '/' '*'%nonassoc '='
%type <str> E
%%
start: '$' {int i;
printf("\nINTERMEDIATE CODE ");
printf("\n----------- *********** -------------");
printf("\noper\topd1\topd2\tresult");
for(i=0;i<icc;i++)
{
printf("\n%c\t%s\t%s\t%s",ic[i].opr,ic[i].opd1,ic[i].opd2,ic[i].res);
};
printf("\n----------- *********** -------------");
}
| id'='E';' {emit('=',$3," ",$1);yyparse();}
;
E:
E'+'E { sprintf($$,"t%d",temp++);
emit('+',$1,$3,$$);
}
|E'-'E { sprintf($$,"t%d",temp++);
emit('-',$1,$3,$$);
}
|E'/'E { sprintf($$,"t%d",temp++);
emit('/',$1,$3,$$);
}
|E'*'E { sprintf($$,"t%d",temp++);
emit('*',$1,$3,$$);
}
|id {}
|digit {sprintf($$,"%d",$1);}
;
%%
void emit(char oper,char op1[20],char op2[20],char rss[20])
{
ic[icc].opr=oper;
strcpy(ic[icc].opd1,op1);
strcpy(ic[icc].opd2,op2);
strcpy(ic[icc].res,rss);
icc++;}
void opt()
{
int i,j;
for(i=0;i<icc;i++)
{
if(ic[i].opr=='=')
{
if((strcmp(ic[i-1].res,ic[i].opd1)==0)||(strcmp(ic[i-1].res,ic[i].opd2)==0))
{
strcpy(ic[i-1].res,ic[i].res);
for(j=i;j<icc-1;j++)
{
ic[j].opr=ic[j+1].opr;
strcpy(ic[j].opd1,ic[j+1].opd1);
strcpy(ic[j].opd2,ic[j+1].opd2);
strcpy(ic[j].res,ic[j+1].res);
}
icc--;
}
}
}
}
void opt2()
{
int i,j,k;
for(i=0;i<icc;i++)
{
for(j=i+1;j<icc;j++)
{
if(ic[i].opr==ic[j].opr&&(strcmp(ic[i].opd1,ic[j].opd1)==0)&&(strcmp(ic[i].opd2,ic[j].opd2)==0))
{
//strcpy(ic[j].opd1,ic[i].res);
strcpy(ic[j+1].opd2,ic[i].res);
for(k=j;k<icc;k++)
{
ic[k].opr=ic[k+1].opr;
strcpy(ic[k].opd1,ic[k+1].opd1);strcpy(ic[k].opd2,ic[k+1].opd2);
strcpy(ic[k].res,ic[k+1].res);
}
icc--;
break;
}
}
}
}
void disp()
{
int i;
printf("\nOPTIMIZED CODE ");
printf("\n----------- *********** -------------");
printf("\noper\topd1\topd2\tresult");
for(i=0;i<icc;i++)
{
printf("\n%c\t%s\t%s\t%s",ic[i].opr,ic[i].opd1,ic[i].opd2,ic[i].res);
}
printf("\n----------- *********** -------------\n\n");
}
int main()
{
fp=fopen("aa.txt","r");
yyparse();
opt();
disp();
opt2();
disp();
return;
}
void yyerror(const char *s)
{
printf("\n");
}

/*....................aa.txt...................
l=a+b/c*d;
p=a*10-b/c;
y=l;
x=y+p;
$*/



/*Output:
student@student-OptiPlex-3020:~$ lex 15a.l
student@student-OptiPlex-3020:~$ yacc -d 15b.y
student@student-OptiPlex-3020:~$ gcc lex.yy.c y.tab.c
15b.y:53:6: warning: conflicting types for ‘emit’ [enabled by default]
 void emit(char oper,char op1[20],char op2[20],char rss[20])
      ^
15b.y:34:6: note: previous implicit declaration of ‘emit’ was here
 | id'='E';' {emit('=',$3," ",$1);yyparse();}
      ^
15b.y:127:6: warning: conflicting types for ‘yyerror’ [enabled by default]
 void yyerror(const char *s)
      ^
y.tab.c:1330:7: note: previous implicit declaration of ‘yyerror’ was here
       yyerror (YY_("syntax error"));
       ^
student@student-OptiPlex-3020:~$ ./a.out <aa.txt





INTERMEDIATE CODE 
----------- *********** -------------
oper	opd1	opd2	result
/	b	c	t1
*	t1	d	t2
+	a	t2	t3
=	t3	 	l
*	a	10	t4
/	b	c	t5
-	t4	t5	t6
=	t6	 	p
=	l	 	y
+	y	p	t7
=	t7	 	x
----------- *********** -------------

OPTIMIZED CODE 
----------- *********** -------------
oper	opd1	opd2	result
/	b	c	t1
*	t1	d	t2
+	a	t2	l
*	a	10	t4
/	b	c	t5
-	t4	t5	p
=	l	 	y
+	y	p	x
----------- *********** -------------


OPTIMIZED CODE 
----------- *********** -------------
oper	opd1	opd2	result
/	b	c	t1
*	t1	d	t2
+	a	t2	l
*	a	10	t4
-	t4	t1	p
=	l	 	y
+	y	p	x
----------- *********** -------------

student@student-OptiPlex-3020:~$ */

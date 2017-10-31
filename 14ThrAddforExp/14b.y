%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
struct icode{
char opr;
char op1[10],op2[10],res[10];
}ic[10];
int temp=1,ic_cnt=0;
FILE *fin=NULL;
%}%union{
char str[10];
int no;
};
%token <str> ID
%token <no> DIGIT
%type <str> E
%left '+''-'
%left '*''/'
%nonassoc '='
%%
st:'$' { int i=0;
printf("\n\t======================================================\
n");
printf("\n\tOperator\top1\t\top2\t\tResult");
printf("\n\t======================================================\
n");
for(i=0;i<ic_cnt;i++)
{
printf("\n\t%c\t\t%s\t\t%s\t\t%s",ic[i].opr,ic[i].op1,ic[i].op2,ic[i].res);
printf("\n");
}
printf("\n\n");
exit(0);
}
|ID'='E';'{emit('=',$3,"",$1);yyparse();};

E:E'+'E {sprintf($$,"t%d",temp++); emit('+',$3,$1,$$);}
|E'-'E {sprintf($$,"t%d",temp++); emit('-',$3,$1,$$);}
|E'*'E {sprintf($$,"t%d",temp++); emit('*',$3,$1,$$);}
|E'/'E {sprintf($$,"t%d",temp++); emit('/',$3,$1,$$);}
|ID {}
|DIGIT {sprintf($$,"%d",$1);};

%%

void emit(char oper,char opd1[10],char opd2[10],char result[10])
{
ic[ic_cnt].opr=oper;
strcpy(ic[ic_cnt].op1,opd1);
strcpy(ic[ic_cnt].op2,opd2);
strcpy(ic[ic_cnt].res,result);
ic_cnt++;
}
int main()
{
fin=fopen("14.txt","r");
if(!fin)
{
printf("\n\nUnable to open file...!!!");
exit(1);
}
yyparse();
fcloseall();
return(0);
}


//................14.txt..............
//a=a+b/c-d;$


/*Output:
student@student-OptiPlex-3020:~$ lex 14a.l
student@student-OptiPlex-3020:~$ yacc -d 14b.y
student@student-OptiPlex-3020:~$ gcc lex.yy.c y.tab.c
14b.y:47:6: warning: conflicting types for ‘emit’ [enabled by default]
 void emit(char oper,char opd1[10],char opd2[10],char result[10])
      ^
14b.y:36:6: note: previous implicit declaration of ‘emit’ was here
 |ID'='E';'{emit('=',$3,"",$1);yyparse();};
      ^
student@student-OptiPlex-3020:~$ ./a.out <14.txt

	======================================================n
	Operator	op1		op2		Result
	======================================================n
	/		c		b		t1

	+		t1		a		t2

	-		d		t2		t3

	=		t3				a


student@student-OptiPlex-3020:~$ */

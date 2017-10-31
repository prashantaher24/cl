%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
typedef struct intercode
{
char optor;
char op1[10];
char op2[10];
char res[10];
}intercode;
intercode ic_if[50],ic_else[50];
int allrows,temp=1,cnt_if=0;
char goto_if[]="goto L0\0",goto_else[]="goto L1\0";
%}
%union
{
int no;
char str[10];
}
%token <str> if_id
%token <str> else_id
%token <str> rel_op
%token <str> clocrl
%token <str> opcrl
%token <str> bracs_op
%token <str> bracs_cl
%token <str> id
%token <no> digit
%type <str> expr
%left '+' '-'
%left '*' '/'
%nonassoc '='

%%
start : if_id bracs_op id rel_op id bracs_cl opcrl start {}
|'$' {exit(0);}
|id'='expr';'{ emit_if('=',$3,"",$1); yyparse();}
|clocrl{printf("goto L0 \n goto L1");
int i=0;
        printf("\n \t L0 :\t" );
        for(i=0;i<cnt_if;i++)
{
printf("%c",ic_if[i].optor);
printf("\t\t %s",ic_if[i].op1);
printf("\t\t %s",ic_if[i].op2);
printf("\t\t %s\n\t\t",ic_if[i].res);
}
yyparse();
}

;

expr : expr'+'expr {sprintf($$,"t%d",temp); temp++; emit_if('+',$1,$3,$$);}
        | expr'-'expr {sprintf($$,"t%d",temp); temp++; emit_if('-',$1,$3,$$);}
        | expr'*'expr {sprintf($$,"t%d",temp); temp++; emit_if('*',$1,$3,$$);}
        | expr'/'expr {sprintf($$,"t%d",temp); temp++; emit_if('/',$1,$3,$$);}
        |id {}
        |digit{}
        ;
%%
int main(int argc,char *argv[])
{
FILE *fp;
fp=fopen("input","r");
if(!fp)
{
printf("cnt open:%s",argv[1]);
exit(1);
}
yyparse();
return 0;
}

void emit_if(char opr,char *op1, char *op2,char *res)
{
ic_if[cnt_if].optor=opr;
strcpy(ic_if[cnt_if].op1,op1);
strcpy(ic_if[cnt_if].op2,op2);
strcpy(ic_if[cnt_if].res,res);
cnt_if++;
}

/*...................Input................
if(m<n)
{
res=m-n;
}
$*/




/*Output:
 tudent@student-OptiPlex-3020:~$ lex 12a.l
student@student-OptiPlex-3020:~$ yacc -d 12b.y
student@student-OptiPlex-3020:~$ gcc lex.yy.c y.tab.c
12b.y:75:6: warning: conflicting types for ‘emit_if’ [enabled by default]
 void emit_if(char opr,char *op1, char *op2,char *res)
      ^
12b.y:38:7: note: previous implicit declaration of ‘emit_if’ was here
 |id'='expr';'{ emit_if('=',$3,"",$1); yyparse();}
       ^
student@student-OptiPlex-3020:~$ ./a.out <input
if(m<n)goto L0 
 goto L1
 	 L0 :	-		 m		 n		 t1
		=		 t1		 		 res
		student@student-OptiPlex-3020:~$ ./a.out <input
if(mn)syntax error at line no 1 for ) student@student-OptiPlex-3020:~$ */



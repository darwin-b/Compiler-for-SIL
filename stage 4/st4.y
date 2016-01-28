%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "st4.h"
	#include "st4.c"
	
	int yylex(void);
        struct treenode *root,*temp;
	


%}

%token NUM PLUS MINUS MUL DIV END READ ASSIGN ID WRITE LT GT EQUAL ENDIF THEN DO IF ELSE ENDWHILE WHILE SEMI
%left PLUS MINUS
%left MUL DIV
%right ASSIGN
%nonassoc LT GT EQUAL

%union{
	 struct treenode *nodeptr;
};

%type <nodeptr> expr
%type <nodeptr> ID
%type <nodeptr> stmt
%type <nodeptr> NUM
%type <nodeptr> slist


%%

Program : slist END      		{ evaluate($1);	exit(1);}
	 	;


slist : slist stmt   			{
									temp = (struct treenode *)malloc(sizeof(struct treenode ));
		                            temp->nodetype=INITIAL;
		                            temp -> ptr1 = $2;
		                            temp -> ptr2 = $1;
		       						$$=temp;
								}

  	  | stmt 					{$$=$1;}
  	  ;


stmt : ID ASSIGN expr ';'  						{$$ = maketreeNode(VOID,ASSIGN_NODE,0,NULL,NULL,$1,$3,NULL);}
	 | READ '(' ID ')' ';' 						{$$ = maketreeNode(VOID,READ_NODE,0,NULL,NULL,NULL,$3,NULL);}
	 | WRITE '(' expr ')' ';'					{$$ = maketreeNode(VOID,WRITE_NODE,0,NULL,NULL,NULL,$3,NULL);}
	 | IF '(' expr ')' THEN slist ENDIF ';'			{$$ = maketreeNode(VOID,IF_NODE,0,NULL,NULL,$3,$6,NULL);}
	 | IF '(' expr ')' THEN slist ELSE slist ENDIF ';' 	{$$ = maketreeNode(VOID,IF_ELSE_NODE,0,NULL,NULL,$3,$6,$8);}
	 | WHILE '(' expr ')' DO slist ENDWHILE ';' 	{$$ = maketreeNode(VOID,WHILE_NODE,0,NULL,NULL,$3,$6,NULL);}
	 ;



expr : expr PLUS expr			{$$ = maketreeNode(INT,'+',0,NULL,NULL,$1,$3,NULL);}
	 | expr MINUS expr  		{$$ = maketreeNode(INT,'-',0,NULL,NULL,$1,$3,NULL);}
	 | expr MUL expr			{$$ = maketreeNode(INT,'*',0,NULL,NULL,$1,$3,NULL);}
	 | expr DIV expr			{$$ = maketreeNode(INT,'/',0,NULL,NULL,$1,$3,NULL);}
	 | expr LT expr				{$$ = maketreeNode(BOOL,'<',0,NULL,NULL,$1,$3,NULL);}
	 | expr GT expr				{$$ = maketreeNode(BOOL,'>',0,NULL,NULL,$1,$3,NULL);}
	 | expr EQUAL expr			{$$ = maketreeNode(BOOL,EQUAL_NODE,0,NULL,NULL,$1,$3,NULL);}
	 | '(' expr ')'				{$$ = $2;}
	 | NUM					{$$ = $1;}
	 | ID 					{$$ = $1;}
	 ;

%%

yyerror(char const *s)
{
    printf("yyerror %s",s);
}


int main(void) 
{
	yyparse();
	return 0;
}    

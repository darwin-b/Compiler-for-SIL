%{
	#include <stdio.h>
	#include "y.tab.h"
	#include "st4.h"
	#include <stdlib.h>
	#include <string.h>

	int number;
%}

%%

[a-z]    { yylval.nodeptr = maketreeNode(VOID,ID_NODE,0,yytext,NULL,NULL,NULL,NULL);return ID; printf("%c ",*yytext);}
[0-9]+	{number = atoi(yytext); yylval.nodeptr = maketreeNode(INT,NUM_NODE,number,NULL,NULL,NULL,NULL,NULL);return NUM; printf("%d ",atoi(yytext));}
"+"		{return PLUS;}
"-"		{return MINUS;}
"*"		{return MUL;}
"/"		{return DIV;}
"<" 		{return LT;}
">" 		{return GT;}
"==" 		{return EQUAL;}
"read"  	{return READ;} 
"write" 	{return WRITE;}
"if" 		{return IF;}
"then" 		{return THEN;}
"while" 	{return WHILE;}
"endwhile" 	{return ENDWHILE;}
"endif" 	{return ENDIF;}
"do" 		{return DO;}
"else" 		{return ELSE;}


[=]      { return ASSIGN;}
";"	 {return *yytext;}
[ \t]	{}
[()]	{return *yytext;}
[\n]	{return END;}
.	{yyerror("unknown character\n");exit(1);}

%%

int yywrap(void) {
	return 1;
}

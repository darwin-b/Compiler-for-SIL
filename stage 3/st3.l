%{
	#include <stdio.h>
	#include "y.tab.h"
	#include <stdlib.h>

	int number;

%}

%%

[a-z]    { yylval.character = *yytext; return ID;}
[0-9]+	{number = atoi(yytext); yylval.integer = number; return NUM;}
"+"	{return PLUS;}
"-"	{return MINUS;}
"*"	{return MUL;}
"/"	{return DIV;}
"read"   { return READ;} 
"write"  {return WRITE;}
[=]      { return ASGN;}
";"	{return *yytext;}
[ \t]	{}
[()]	{return *yytext;}
[\n]	{return END;}
.	{yyerror("unknown character\n");exit(1);}

%%

int yywrap(void) {
	return 1;
}

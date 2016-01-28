%{
	#include <stdio.h> 
	#include <stdlib.h>
	#include "y.tab.h"
%}

%%

(-[0-9]+|[0-9]+)	{yylval = atoi(yytext);return DIGIT;}
"+"	return *yytext;
"*"	return *yytext;
"-" return *yytext;
"/" return *yytext;
"("	return *yytext;
")"	return *yytext;
"\n" return *yytext;

[ \n\t] {} 
.       { yyerror("Invalid charater "); printf("%s\n",yytext); exit(1); }

%%


yyerror(char const *s)
{ 
   printf("yyerror %s",s); 
} 

yywrap()
{
	return 1;
}


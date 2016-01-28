%option noyywrap

%{
	#include<stdio.h>
	#include<stdlib.h>

%}

number [1-9]+
zero [0]+


%%

{number}	{
				printf("%d",atoi(yytext));
			}
{zero}  	{}	

%%

int main()
{
	int i,j;
	yylex();

	return 1;
	
}

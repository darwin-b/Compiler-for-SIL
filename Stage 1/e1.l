//Odd or Even

%option noyywrap
%{
	#include <stdlib.h>
	#include <stdio.h>
%}
	
number [0-9]+
 
%%
 
{number} 	{	
				printf("Found : %d\n",atoi(yytext));
				return atoi(yytext);
			}
 
%%
 
int main()
{
	int j= 6,i;
	while(j--)
	{
		i= yylex();
		if(i%2)
			printf("ODD");
		else
			printf("Even");
	}
	return 1;
}
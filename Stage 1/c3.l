%option noyywrap
%{
	#include<stdio.h>
	#include<stdlib.h>
	int count;
%}



mat "st"
match "the"
string [a-zA-Z]
end [\n]



%%

{match}		{
				count++;
				printf("count: %d %s",count,yytext);
			}



{mat} { count++;
				printf("count: %d %c",count,*yytext);}


%%

int main()
{
	int j;
	j = yylex();
	return 1;
}
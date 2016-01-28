

%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<math.h>
	int i,l,n,rem,val=0;

%}

bin [0-1]
notbin [2-9]+

%option noyywrap

%%

{bin}		{
				n=atoi(yytext);
				val = val*2 + n;
				printf(" bin_val: %d ",val);

			}

({bin}*{notbin})  	{
						printf("Not a binary number\n");
						return 0;
					}	

%%

int main()
{
	int j;
	j = yylex();
	return 1;
	
}

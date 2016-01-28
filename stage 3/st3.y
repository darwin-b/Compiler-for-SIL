%{
	#include <stdio.h>
	#include <stdlib.h>
	
	
	int yylex(void);
	int *var[26];


%}

%token NUM PLUS MINUS MUL DIV END READ ASGN ID WRITE
%left PLUS MINUS
%left MUL DIV

%union 	{
		   int integer;
		   char character; 
};

%type <integer>  expr
%type <character> ID
%type <integer> stmt
%type <integer> NUM


%%


Program : slist END     { exit(0);} 
	 ;

slist : slist stmt   
  	  | stmt 
  	  ;


expr : expr PLUS expr		{$$ = $1+$3;}
	 | expr MINUS expr  	{$$ = $1-$3;}
	 | expr MUL expr	{$$ = $1*$3;}
	 | expr DIV expr	{$$ = $1/$3;}
	 | '(' expr ')'		{$$ = $2;}
	 | NUM			{$$ = $1;}
	 | ID 			{
		       		    if( var[$1 - 'a'] == NULL)
		       		         printf("unassinged varaiable");
		      		    else
		                	$$ = *var[$1 - 'a'];
	    	      		}

	  ;

stmt : ID ASGN expr ';'      	{
					if(var[$1-'a'] == NULL)
			   			var[$1 - 'a'] = malloc(sizeof(int));
					
					*var[$1 - 'a'] = $3;
				}

	 | READ '(' ID ')' ';'  {
					if(var[$3-'a'] == NULL)
			   			var[$3 - 'a'] = malloc(sizeof(int));
					

					scanf("%d",var[$3-'a']);    
	  			}

	 | WRITE '(' expr ')' ';'   {	printf("%d",$3) ;   }

	 ;


%%

yyerror(char const *s)
{
    printf("yyerror %s",s);
}


int main(void) {
	yyparse();
	return 0;
	}    

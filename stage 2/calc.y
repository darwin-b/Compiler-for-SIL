 %{

    #include <stdio.h>
    #include <stdlib.h>

%}

%token DIGIT
%left '+' '-'
%left '*' '/'

%%

start : expr '\n'          {printf("\n Expression value: %d \n",$1);exit(0);}
    ;

expr: expr '+' expr     {$$ = $1 + $3; }
    | expr '-' expr     {$$ = $1 - $3; }
    | expr '*' expr     {$$ = $1 * $3; }
    | expr '/' expr     {
                            if($3!=0)
                            $$ = $1 / $3;
                            else
                            {
                            printf("Division by zero not allowed\n");
                            exit(0);
                            }
                        }
    | '(' expr ')'      {$$=$2;}
    | DIGIT             {$$=$1;}
    ;

%%


main()
{
    yyparse();
    return 1;
}
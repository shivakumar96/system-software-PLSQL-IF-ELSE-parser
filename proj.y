%{
int yylex();
int yyerror();
%}
%{
#include<stdio.h>
#include<stdlib.h>
int flag = 0;
extern int linecount ;
extern FILE *yyin ;
%}
%token ENDIF ELSEIF ELSE THEN IF EQ NUM WS REOP BOOLOP BOOLVAL COMPOP OUTPUT VARIABLE LP RP NL
%%
S  : ifelstm 
   ;
ifelstm: IF check THEN ws stm nl ws ENDIF
       | IF check THEN ws stm nl ws elif ELSE ws stm nl ws ENDIF  
       ;

check  : ws LP ws cond ws RP ws
       ;

elif   : ELSEIF check THEN ws stm nl ws elif
       |
       ;

cond   : NUM ws REOP ws NUM
       | VARIABLE ws REOP ws NUM
       | VARIABLE ws REOP ws VARIABLE
       | NUM ws REOP ws VARIABLE
       | BOOLVAL
       | NUM ws COMPOP ws VARIABLE
       | VARIABLE ws COMPOP ws VARIABLE
       | VARIABLE ws BOOLOP ws VARIABLE
       ;
        

stm    : stm nl ws VARIABLE ws EQ ws NUM ws ';' ws
       | stm nl ws OUTPUT ws
       | NL no ws OUTPUT ws
       | NL no ws VARIABLE ws EQ ws NUM ws ';' ws
       ;


ws     : WS
       |
       ;

no     : no NL
       | 
       ;

nl     : nl NL
       | NL 
       ;
%%

int yyerror()
{
 
 //printf("error at line %d\n",linecount) ;
 flag = linecount ;
}

int main(int argc, char* argv[])
{
   if(argc == 1) return -1;
yyin = fopen(argv[1],"r") ;
yyparse();
printf("%d",flag) ;
return 0 ;
}

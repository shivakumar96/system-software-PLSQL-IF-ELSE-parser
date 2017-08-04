%{
#include<stdio.h>
#include"y.tab.h"
int linecount  = 1;
int if_flag = 0 ;
int b_flag = 0 ;
%}  
%%
[Ee][Nn][Dd][ ][Ii][Ff][ \t]*[;]                { if_flag = 0 ;             return ENDIF  ;                           }
[Ee][Ll][Ss][Ii][Ff]                            { b_flag =1   ;             return ELSEIF ;                           }
[Ee][Ll][Ss][Ee]                                {                           return ELSE   ;                           }
[Tt][Hh][Ee][Nn]                                { b_flag = 0 ;              return THEN   ;                           }
[Ii][Ff]                                        { if_flag = 1 ; b_flag =1 ; return IF ;                               }              
":="                                            { if(if_flag == 1) {        return EQ ;        }                      }
[0-9]*\.?[0-9]+                                 { if(if_flag == 1) {        return NUM;        }                      }
[ \t]+                                          { if(if_flag == 1) {        return WS ;        }                      }
"<"|">"|"="|"!="|"~="|"<>"|"<="|">="            { if(if_flag == 1) {        return REOP;       }                      }
[Aa][Nn][Dd]|[Oo][Rr]|[Nn][Oo][Tt]              { if(if_flag == 1) {        return BOOLOP ;    }                      }
"TRUE"|"FALSE"                                  { if(if_flag == 1) {        return BOOLVAL ;   }                      }
"LIKE"|"IS NULL"|"IN"                           { if(if_flag == 1) {        return COMPOP ;    }                      }
"dbms_output.put_line("[^)\n]*")"[ \t]*";"      { if(if_flag == 1) {        return OUTPUT ;    }                      }
[a-zA-z][a-zA-z0-9]*                            { if(if_flag == 1) {        return  VARIABLE ; }                      }
"("                                { if(if_flag == 1 && b_flag ==1){        return LP ; } else if(if_flag == 1) { return yytext[0] ;}  } 
")"                                { if(if_flag == 1 && b_flag ==1){        return RP ; } else if(if_flag == 1) { return yytext[0] ;}  }
[\n]                               { linecount++;  if(if_flag == 1){        return NL ;}                              }             
.                                               { if(if_flag == 1) {        return yytext[0] ;}                       }
%%

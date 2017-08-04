#include<stdio.h>
#include<stdlib.h>
//#include"lex.yy.c"
//extern FILE* yyin ;

int setup() ;

int main(int argc ,char ** argv )
{
  FILE * fp ;
  
  int i , no , sval ;
  
   sval = setup() ;
   if(sval != 0)
    {
       printf("internal error \n");
       return -1 ;
     }    

   i = system("./proj.out input.txt >out");
  if(i != 0)
    {
       printf("internal error \n");
       return -1 ;
     }
 
   fp = fopen("out","r");

   if(fp == NULL )
    {
       printf("internal error \n");
       return -1 ;
     }

    fscanf(fp,"%d",&no) ;

   if( no == 0 )
     {
          printf("sucessfully parsed\n") ;
          
     }
     else
      {
             printf(" error at line no : %d \n",no);
          }
    
  
  return 0 ;
}

int setup()
{
  int a,b,c ;
  a = system("lex proj.l");
  b = system("yacc -d proj.y");
  c = system("cc lex.yy.c y.tab.c -ll -o proj.out");

 return a|b|c ;  

}


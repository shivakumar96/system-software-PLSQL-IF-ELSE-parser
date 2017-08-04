#include <jni.h>
#include<string.h>
#include<stdlib.h> 
#include <stdio.h> 
#include "C_Caller.h"

int setup() ;

JNIEXPORT jint JNICALL Java_C_1Caller_initialSetup(JNIEnv *env, jobject thisObj)
{

   int sval ;
      sval = setup() ;
   if(sval != 0)
    {
       //printf("internal error \n");
       return -1 ;
     }
   else{
  
       return 1 ;
     }


} 

JNIEXPORT jint JNICALL Java_C_1Caller_callParser (JNIEnv * env, jobject thisObj, jstring fname )
{
     int i , no ;
     FILE * fp  ;
     char* pref = "./proj.out " ;
     char* suff = " >out" ; 
     char cm[400] ;
     char fpath[256] ;
    
     const char *inCStr = (*env)->GetStringUTFChars(env, fname, NULL); 
        
          strcpy(fpath,inCStr);
          strcpy(cm,pref) ;
          strcat(cm,fpath);
          strcat(cm,suff) ;

         // printf(" path is : %s \n",cm) ;
       
          system("rm out");
       
 
       
      i = system(cm);

     // error in getting  output

      if(i != 0)
    {
       //printf("internal error \n");
       return -1 ;
     }
 
   fp = fopen("out","r"); //open the file

   if(fp == NULL )
    {
       //printf("internal error \n"); // error in opening a file
       return -1 ;  
     }

    fscanf(fp,"%d",&no) ; // get the output 

     
 
    return no  ;    
     

}


int setup()
{
  int a,b,c ;
  a = system("lex proj.l");
  b = system("yacc -d proj.y");
  c = system("cc lex.yy.c y.tab.c -ll -o proj.out");

 return a|b|c ;  

}

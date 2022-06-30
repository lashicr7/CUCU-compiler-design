%{
#include<stdio.h>
#include<stdlib.h>
#include "cucu.tab.h"

FILE *output;
void yyerror(char *);
%}

%%
"\/\*(.)* \*\/" {fprintf(output,"comments: %s\n",yytext);}
"int"|"char \*" {fprintf(output,"Type: %s\n",yytext);return Type;}
"if" {fprintf(output,"If: %s\n",yytext);return If;}
"else" {fprintf(output,"Else: %s\n",yytext);return Else;}
"while" {fprintf(output,"While: %s\n",yytext);return While;}
"return" {fprintf(output,"Return: %s\n",yytext);return Return;}
">"|"<"|">="|"<="|"==" {yylval.strn=strdup(yytext); fprintf(output,"Operatorcompr: %s\n",yytext);return Operatorcompr;}
"=" {fprintf(output,"Assign: %s\n",yytext);return Assign;}
"\(" {fprintf(output,"Bropen: %s\n",yytext);return Bropen;}
"\)" {fprintf(output,"Brclose: %s\n",yytext);return Brclose;}
"++"|"--" {fprintf(output,"Operatorincrdecr: %s\n",yytext);return Operatorincrdecr;}
"\/"|"\-"|"\*"|"\+" {yylval.strn=strdup(yytext);fprintf(output,"OperatorAr: %s\n",yytext);return OperatorAr;}
";" {fprintf(output,"Semi: %s\n",yytext);return semi;}
"\," {fprintf(output,"comma: %s\n",yytext);return comma;}
[a-zA-Z][a-zA-Z0-9_]* {yylval.strn=strdup(yytext);fprintf(output,"Id: %s\n",yytext);return Id;}
[0-9]+ {yylval.strn=strdup(yytext);fprintf(output,"Int: %s\n",yytext);return Int;}
"\{" {fprintf(output,"Flopen: %s\n",yytext);return Flopen;}
"\}" {fprintf(output,"Flclose: %s\n",yytext);return Flclose;}
"\"" {fprintf(output,"exlaim: %s\n",yytext);return exclaim;}
"\[" {fprintf(output,"sqropen: %s\n",yytext);return sqropen;}
"\]" {fprintf(output,"sqrclose: %s\n",yytext);return sqrclose;}
[ ]				//space ignore
. 

%%
void yyerror(char *s){
printf("error %s\n",s);
}

       
          






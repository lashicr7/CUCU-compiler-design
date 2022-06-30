%{
#include<stdio.h>
#include<stdlib.h>
extern int yylex();
FILE *output;
FILE *output1;
FILE *yyin;
void yyerror(char *);

%}
%union{
	int numb;
	char * strn;
}


%token Type If Else While Return <strn>Operatorcompr Assign Bropen Brclose Operatorincrdecr <strn>OperatorAr semi 
%token <strn>Id <strn>Int Flopen Flclose exclaim sqropen sqrclose comma
%%
prog : prg prog | prg					{fprintf(output1,"program ENDED");};
prg: variabledecl|functiondecl|functiondef;

variabledecl: Type Id semi {fprintf(output1,"\n");}|Type Id {fprintf(output1,"Variable: %s ",$2);}  Assign {fprintf(output1,"=");}express semi {fprintf(output1,"\n");};

functiondecl: Type Id Bropen functionarg Brclose semi ;
functiondef: Type Id Bropen functionarg Brclose body ;
smallarg: Type Id {fprintf(output1," argument: %s\n",$2);};
functionarg: Type Id {fprintf(output1," argument: %s ",$2);} comma functionarg |smallarg| ;
funcarg:Id {fprintf(output1," argument: %s ",$1);} comma funcarg|Id {fprintf(output1," argument: %s ",$1);}| ;
body: Flopen stmnts Flclose;
func: Id {fprintf(output1," functioncall: %s ",$1);} Bropen funcarg Brclose;
stmnts: stmnts stat | stat
stat:		variabledecl {fprintf(output1,"\n");}
              |functiondecl {fprintf(output1,"\n");}
              |functiondef {fprintf(output1,"\n");}
              |if Flopen stmnts Flclose {fprintf(output1,"\n");} else stmnts {fprintf(output1,"\n");}
              |if Flopen stmnts Flclose {fprintf(output1,"\n");}
              |while Flopen stmnts Flclose {fprintf(output1,"\n");}
              |return {fprintf(output1,"\n");}
              |express semi {fprintf(output1,"\n");};
              
compexr:Id   Operatorcompr Id {fprintf(output1,"variable: %s  operator:%s num:%s	\n",$1,$2,$3);}
     |Int  Operatorcompr Id {fprintf(output1,"num: %s operator:%s variable:%s	\n",$1,$2,$3);}
     |Int  Operatorcompr Int {fprintf(output1,"num:%s operator:%s num:%s		\n",$1,$2,$3);}
     |Id  Operatorcompr Int {fprintf(output1,"variable: %s operator:%s num:%s	\n",$1,$2,$3);}
     |Id |Int {fprintf(output1,"Num: %s		",$1);};
     
if: If {fprintf(output1,"If	");} Bropen compexr  Brclose ;
   
else:Else {fprintf(output1,"Else	");};

return:Return {fprintf(output1,"Return	");} express semi;

while:While {fprintf(output1,"While	");} Bropen compexr Brclose {fprintf(output1,"\n");};

express:arithmetic
        |Int {fprintf(output1,"Num: %s		",$1);}
        |Id {fprintf(output1,"Id: %s	",$1);} |func|assign|
        ;
assign:express Assign {fprintf(output1,"=	");} express;
arithmetic: express OperatorAr express {fprintf(output1,"operation:%s",$2);};
%%
int main(int argc,char **argv){
  
    yyin=fopen(argv[1],"r");
  
   output=fopen("Lexer.txt","w");
   output1=fopen("parser.txt","w");
   yyparse();
   yylex();
          return 0;
}

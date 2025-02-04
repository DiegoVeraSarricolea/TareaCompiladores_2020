%option noyywrap
 
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #include "sintactico.tab.h"

    int lineno = 1; // initialize to 1
    
    //void ret_print(char *tipo_token);
    //void yyerror();
    
%}
 
%x ML_COMMENT
 
letras       [a-zA-Z]
digito       [0-9]
ID           [a-z][a-zA-Z0-9]+

 
NOMAR        "L"{letras}*{digito}+
ENTERO      [0-9]+

%%


{ENTERO} {yylval.numero=atoi(yytext); return(ENTERO);}
{ID} {return (ID);}
{NOMAR} {yylval.texto=yytext; return (NOMARR);}

       
<ML_COMMENT>"\n"        { lineno += 1; }
 
"PARTIR" {return (partir);}
"INICIAR" {return (iniciar);}
"MIRAR" {return (mirar);}
"METER" {return (meter);}
"SACAR" {return (sacar);}
"DATO"  {return (dato);}
"FINALIZAR" {return (finalizar);}


"(" {return (PARA);}
")" {return (PARC);}
"," { return (COMA);}
"=" {return '=';}
[ \t] ; /* ignora espacios */
"\n"            { lineno += 1; }
[ \t\r\f]+          /*Borra espacio en blanco */
 
%%

/* 
void ret_print(char *tipo_token){
    printf("yytext: %s\ttoken: %s\tlineno: %d\n", yytext, tipo_token, lineno);
}
 
void yyerror(char *mensaje){
    printf("Error: \"%s\" en linea %d. Token = %s\n", mensaje, lineno, yytext);
    exit(1);
}
 
int main(int argc, char *argv[]){
    printf("Ingrese Tokens(Palabras reservadas, enteros, simbolos, identificadores): ");
    yylex();
    return 0;
}

*/
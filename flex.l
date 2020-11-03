%option noyywrap
 
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    int lineno = 1; // initialize to 1
    void ret_print(char *tipo_token);
    void yyerror();
%}
 
%x ML_COMMENT
 
letras       [a-zA-Z]
digito       [0-9]

 
ID          "L"{letras}*{digito}+
ENTERO      {digito}+

%%

       
<ML_COMMENT>"\n"        { lineno += 1; }
 
"PARTIR" |
"INICIAR" |
"METER" |
"SACAR" |
"DATO"  | 
"FINALIZAR" {ret_print("RESERVADO");}

{ENTERO} {ret_print("ENTERO");}
{ID} {ret_print("ID");}
"(" |
")" |
"," {ret_print("SIMBOLO");}
[ \t] ; /* ignora espacios */
"\n"            { lineno += 1; }
[ \t\r\f]+          /*Borra espacio en blanco */
 
.               { yyerror("Caracter desconocido"); }
 
%%
 
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
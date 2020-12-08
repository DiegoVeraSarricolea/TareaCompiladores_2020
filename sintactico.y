%{

/********************** 
 * Declaraciones en C *
 **********************/

 //Importacion de librerias
  #include <stdio.h>
  #include <stdlib.h>
  #include <math.h>
  #include "string.h"
  

  extern int yylex(void);
  extern char *yytext;
  extern FILE *yyin;
 
 //Declaracion de metodos 
  void yyerror(char *s);
  void creaArreglo(char id[30],int x1,int x2,int x3,int x4,int x5,int x6,int x7,int x8);
  void meterEnArreglo(char id[30],int x,int y);
  void sacarDeArreglo(char id[30],int y);
  void mirarArreglo(char id[30]);
  int datoDeArreglo(char id[30],int x);


//Declaracion del nodo del buffer de identificadores
  struct id {
    char nombre[50];
    int valor;
};

struct arreglo {
    char nombre[50];
    int valor1;
    int valor2;
    int valor3;
    int valor4;
    int valor5;
    int valor6;
    int valor7;
    int valor8;
};

struct arreglo A;

//Declaracion de variables globales
/*
  struct id buffer[1000];
  int pos=0;
  char string[50];
  int x;
  int y;
  int valor1;
  int valor2;
  int valor3;
  int valor4;
  int valor5;
  int valor6;
  int valor7;
  int valor8;
*/

%}

/*************************
  Declaraciones de Bison *
 *************************/

/*Declaración tipo de dato a utilizar en las terminales y variables 
  de la gramatica, en este caso entero y string*/
%union
{
  int numero;
  char* texto;
}

/*Declaración de tokens*/
%token <numero> ENTERO
%token <texto> NOMARR
%token <texto>ID
%token partir
%token iniciar
%token meter
%token sacar
%token mirar
%token dato
%token asignar
%token finalizar


%type <numero> constante
%type <texto> arreglo

%start s

%%

/***********************
 * Reglas Gramaticales *
 ***********************/

/*Inicio de la gramatica*/
s :			PARTE INST FINALIZA	
			;

INST: 		INICIA |
			    METE |
          SACA |
          MIRA |
          DAT
			    ;

INICIA: iniciar '(' arreglo ',' constante ',' constante ',' constante ',' constante ',' constante ',' constante ',' constante ',' constante ')' {creaArreglo($3, $5, $7, $9, $11, $13, $15, $17, $19);}
			;

METE: meter '(' NOMARR ',' ENTERO ',' ENTERO ')' {meterEnArreglo($3,$5,$7);}
		;

SACA: sacar '(' NOMARR ',' ENTERO ')' {sacarDeArreglo($3,$5);}
		;

MIRA: mirar '(' NOMARR ')' {mirarArreglo($3);}
		;

DAT: dato '(' NOMARR ',' ENTERO ')' {datoDeArreglo($3,$5);}
		;

PARTE: partir
	   ;

FINALIZA: finalizar
		  ;

arreglo: NOMARR {
  $$= $1 ;}
      ;


constante: ENTERO {
   scanf("%d", &$1);
  $$= $1 ;}
      ;

%%
/**********************
 * Codigo C Adicional *
 **********************/
void yyerror(char *s)
{
	printf("Error sintactico %s \n",s);
}

void creaArreglo(char id[30],int x1,int x2,int x3,int x4,int x5,int x6,int x7,int x8)
{
	strcpy(A.nombre, id);
	A.valor1 = x1;
  A.valor2 = x2;
  A.valor3 = x3;
  A.valor4 = x4;
  A.valor5 = x5;
  A.valor6 = x6;
  A.valor7 = x7;
  A.valor8 = x8;
	printf("Arreglo creado");
}


void meterEnArreglo(char id[30],int x,int y)
{

}

void sacarDeArreglo(char id[30],int y)
{

}

void mirarArreglo(char id[30])
{

}

int datoDeArreglo(char id[30],int x)
{
return 0;
}



int main(int argc,char **argv) //Programa Principal
{
	yyparse(); //funcion propio de bison que ejecuta el analizador sintactico
	printf("La ejecucion termino de manera correcta ");
	return 0;
}

/* para compilar
win_bison -d sintactico.y
win_flex flex.l
gcc lex.yy.c sintactico.tab.c -o analizador  -lm
*/
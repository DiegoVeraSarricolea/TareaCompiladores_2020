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
  int buscaPosicionArreglo(char id[50]);
  void creaArreglo(char id[30],int x1,int x2,int x3,int x4,int x5,int x6,int x7,int x8);
  void meterEnArreglo(char id[30],int x,int y);
  void sacarDeArreglo(char id[30],int y);
  void mirarArreglo(char id[30]);
  void datoDeArreglo(char id[30],int x);
  void identificadorArreglo(char id[30]);


//Declaracion del nodo del buffer de identificadores
  struct id {
    char nombre[30];
    int valor;
};

struct arreglo A;

char auxiliarArreglo[30];

struct arreglo
{
    char nombre[50];
    int valor[8];
};

struct arreglo buffer[1000];
int aux = 0;
size_t n = sizeof(buffer) / sizeof(buffer[0]);


%}

/*************************
  Declaraciones de Bison *
 *************************/
%union
{
  int numero;
  char* texto;
}

/*Declaración de tokens*/
%token <numero> ENTERO
%token <texto> NOMARR
%token <texto> ID
%token partir
%token iniciar
%token meter
%token sacar
%token mirar
%token dato
%token asignar
%token finalizar

%token PARA
%token PARC
%token COMA


%type <numero> constante
%type <texto> arr
%start s

%%

/***********************
 * Reglas Gramaticales *
 ***********************/

/*Inicio de la gramatica*/
s :			PARTE INST FINALIZA	
			;

INST: 	INST INST|	
        INICIA |
			    METE |
          SACA |
          MIRA |
          DAT
			    ;

INICIA: iniciar PARA arr COMA constante COMA constante COMA constante COMA constante COMA constante COMA constante COMA constante COMA constante PARC {identificadorArreglo($3); creaArreglo(auxiliarArreglo,$5,$7,$9,$11,$13,$15,$17,$19);} |
        iniciar PARA arr COMA constante COMA constante COMA constante COMA constante COMA constante COMA constante COMA constante PARC {identificadorArreglo($3); creaArreglo(auxiliarArreglo,$5,$7,$9,$11,$13,$15,$17,0);} |
        iniciar PARA arr COMA constante COMA constante COMA constante COMA constante COMA constante COMA constante PARC {identificadorArreglo($3); creaArreglo(auxiliarArreglo,$5,$7,$9,$11,$13,$15,0,0);} |
        iniciar PARA arr COMA constante COMA constante COMA constante COMA constante COMA constante PARC {identificadorArreglo($3); creaArreglo(auxiliarArreglo,$5,$7,$9,$11,$13,0,0,0);} |
        iniciar PARA arr COMA constante COMA constante COMA constante COMA constante PARC {identificadorArreglo($3); creaArreglo(auxiliarArreglo,$5,$7,$9,$11,0,0,0,0);} |
        iniciar PARA arr COMA constante COMA constante COMA constante PARC {identificadorArreglo($3); creaArreglo(auxiliarArreglo,$5,$7,$9,0,0,0,0,0);} |
        iniciar PARA arr COMA constante COMA constante PARC {identificadorArreglo($3); creaArreglo(auxiliarArreglo,$5,$7,0,0,0,0,0,0);} |
        iniciar PARA arr COMA constante  PARC {identificadorArreglo($3); creaArreglo(auxiliarArreglo,$5,0,0,0,0,0,0,0);} 
	;

METE: meter PARA NOMARR COMA ENTERO COMA ENTERO PARC {identificadorArreglo($3); meterEnArreglo(auxiliarArreglo,$5,$7);}
		;

SACA: sacar PARA NOMARR COMA ENTERO PARC {identificadorArreglo($3); sacarDeArreglo(auxiliarArreglo,$5);}
		;

MIRA: mirar PARA NOMARR PARC {identificadorArreglo($3); mirarArreglo(auxiliarArreglo);}
		;

DAT: dato PARA NOMARR COMA ENTERO PARC {identificadorArreglo($3); datoDeArreglo(auxiliarArreglo,$5);}
		;

PARTE: partir
	   ;

FINALIZA: finalizar
		  ;

arr: NOMARR { $$ = $1;}
      ;


constante: ENTERO { $$ = $1;}
      ;

%%
/**********************
 * Codigo C Adicional *
 **********************/
void yyerror(char *s)
{
	printf("Error sintactico %s \n",s);
}

void identificadorArreglo(char id[30]){
  int i = 0;
  while( i < 30 && id[i] != ',' && id[i] !=')' ){
    auxiliarArreglo[i] = id[i];
    i++;
  }
}


void creaArreglo(char id[50], int x1, int x2, int x3, int x4, int x5, int x6, int x7, int x8)
{

    //strcpy(buffer, A);
    while (aux < n)
    {
        if (buffer[aux].valor[0] == NULL)
        {
            strcpy(buffer[aux].nombre, id);
            buffer[aux].valor[0] = x1;
            buffer[aux].valor[1] = x2;
            buffer[aux].valor[2] = x3;
            buffer[aux].valor[3] = x4;
            buffer[aux].valor[4] = x5;
            buffer[aux].valor[5] = x6;
            buffer[aux].valor[6] = x7;
            buffer[aux].valor[7] = x8;
            //printf("se agregó %s, en el buffer en la posición %i\n", buffer[aux].nombre, aux);
            break;
        }
        else
        {
            aux = aux + 1;
        }
    }
}


int buscaPosicionArreglo(char id[50])
{ //esta funcion se encarga de retornar el valor que tiene almacenado un id en la tabla de buffer cuando es referenciado

    int p = 0;
    while (strcmp(buffer[p].nombre, id) != 0)
    {
        p++;
    }
    return p;
    //controlar cuando salga del array
}

void meterEnArreglo(char id[50], int x, int y)
{
    int pos = buscaPosicionArreglo(id);
    buffer[pos].valor[y-1] = x;
}

void mirarArreglo(char id[30])
{
    int pos = buscaPosicionArreglo(id);
    //printf("el arreglo %s contiente los siguientes elementos: ", buffer[pos].nombre);
    for (int i = 0; i < 8; i++)
    {
       if (buffer[pos].valor[i] == 0) printf("%i ", buffer[pos].valor[i]);
    }
     printf("\n");
}


void sacarDeArreglo(char id[30],int y)
{
  int pos = buscaPosicionArreglo(id);

  buffer[pos].valor[y-1] = buffer[pos].valor[y];

  int aux = 0;
  for(int i = y; i<7 ;i++) buffer[pos].valor[i] = buffer[pos].valor[i+1];

  buffer[pos].valor[7] = 0;

}


void datoDeArreglo(char id[30],int x)
{
  int pos = buscaPosicionArreglo(id);
  printf("%i ", buffer[pos].valor[x-1]);

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
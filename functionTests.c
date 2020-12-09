#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct arreglo
{
    char nombre[50];
    int valor[8];
};

struct arreglo buffer[1000];
int aux = 0;
size_t n = sizeof(buffer) / sizeof(buffer[0]);

void creaArreglo(char id[50], int x1, int x2, int x3, int x4, int x5, int x6, int x7, int x8);
void meterEnArreglo(char id[30], int x, int y);
void sacarDeArreglo(char id[30], int y);
void mirarArreglo(char id[30]);
int buscaPosicionArreglo(char id[50]);
int datoDeArreglo(char id[50], int x);

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
            printf("se agregó %s, en el buffer en la posición %i\n", buffer[aux].nombre, aux);
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
    buffer[pos].valor[y] = x;
}

void mirarArreglo(char id[30])
{
    int pos = buscaPosicionArreglo(id);
    printf("el arreglo %s contiente los siguientes elementos: ", buffer[pos].nombre);
    for (int i = 0; i < 8; i++)
    {
        printf("%i ", buffer[pos].valor[i]);
    }
}

int main(int argc, char *argv[])
{
    creaArreglo("L12", 1, 2, 3, 4, 5, 6, 7, 8);
    creaArreglo("L13", 1, 2, 3, 4, 5, 6, 7, 8);
    creaArreglo("L14", 1, 2, 3, 4, 5, 6, 7, 8);
    creaArreglo("L15", 1, 2, 3, 4, 5, 6, 7, 8);
    printf("posicion en buffer %i \n", buscaPosicionArreglo("L12"));
    meterEnArreglo("L13", 60, 2);
    printf("valor: %i\n", buffer[1].valor[2]);
    mirarArreglo("L13");
}
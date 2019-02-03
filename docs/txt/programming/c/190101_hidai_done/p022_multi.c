#include <stdio.h>
#define MAX1 10
#define MAX2 10

int main(void) {
  int i;
  int j;
  int kuku[MAX1][MAX2];//2次元配列

  for (i = 0; i < MAX1; i++) {
    for (j = 0; j < MAX2; j++) {
      kuku[i][j] = (i + 1) * (j + 1);
    }
  }

  for (i = 0; i < MAX1; i++) {
    for (j = 0; j < MAX2; j++) {
      printf("%3d, ", kuku[i][j]);
    }
    printf("\n");
  }
}

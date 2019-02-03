#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void) {
  int i;

  srand((unsigned)time(NULL));
  printf("rand() は、%dから%dの値を返す関数\n", 0, RAND_MAX);
  for (i = 0; i < 10; i++) {
    printf("%d\n", rand() % 100);
  }
}

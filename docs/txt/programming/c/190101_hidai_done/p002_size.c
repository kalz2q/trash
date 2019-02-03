#include <limits.h>
#include <stdio.h>

int main(void) {
  printf("sizeof(char  ): %ld\n", sizeof(char));
  printf("sizeof(int   ): %ld\n", sizeof(int));
  printf("sizeof(long  ): %ld\n", sizeof(long));
  printf("sizeof(float ): %ld\n", sizeof(float));
  printf("sizeof(double): %ld\n", sizeof(double));
  printf("CHAR_MIN: %d\n",  CHAR_MIN);
  printf("CHAR_MAX: %d\n",  CHAR_MAX);
  printf("INT_MIN : %d\n",  INT_MIN);
  printf("INT_MAX : %d\n",  INT_MAX);
  printf("LONG_MIN: %ld\n", LONG_MIN);
  printf("LONG_MAX: %ld\n", LONG_MAX);
}

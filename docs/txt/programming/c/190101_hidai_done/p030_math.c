// gcc example.c -lm
#include <math.h>
#include <stdio.h>

int main(void) {
  double rad;//radian
  for (rad = 0; rad < 3.1; rad += 0.1) {
    printf("sin(%3.1f) = %010.8f\n", rad, sin(rad));
  }
}

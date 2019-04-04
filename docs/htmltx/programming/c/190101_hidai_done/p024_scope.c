#include <stdio.h>

int g;//global

void f(int a) {
  int b;

  a += 2;
  g += 2;
  printf("in f() : a = %d\n", a);
  printf("in f() : g = %d\n", g);
}

int main() {
  int a = 10;

  g = 100;
  printf("in main() : a = %d\n", a);
  printf("in main() : g = %d\n", g);
  f(a);// pass by value
  printf("in main() : a = %d\n", a);
  printf("in main() : g = %d\n", g);
}

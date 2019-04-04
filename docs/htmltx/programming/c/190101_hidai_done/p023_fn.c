#include <stdio.h>

int plus(int a, int b) {//関数を定義する。
  return a + b;
}

void func() {
  printf("関数func()の中です。\n");
}

int main() {
  int a, b, c;

  a = 5;
  b = 2;
  c = plus(5, 2);//定義した関数を用いる。
  printf("5 + 2 = %d\n", c);
  printf("5 + 2 = %d\n", plus(a, b));
  func();
}

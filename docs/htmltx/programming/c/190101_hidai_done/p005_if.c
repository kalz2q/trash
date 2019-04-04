#include <stdio.h>

int main(void) {
  int old;

  printf("あなたの年齢は？ >");
  scanf("%d", &old);
  if (old < 20) {
    printf("あなたは未だ違法である。\n");
  } else {
    printf("今度一緒に飲みましょう。\n");
  }
}

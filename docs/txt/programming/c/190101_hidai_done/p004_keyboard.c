#include <stdio.h>

int main(void) {
  int old;
  float weight;

  printf("あなたは何歳ですか？ >");
  scanf("%d", &old);
  printf("すると、10年後は%d歳ですね。\n", old + 10);

  printf("あなたの体重は何キロ？ >");
  scanf("%f", &weight);
  printf("ふーん、そうなんだ。\n");
}

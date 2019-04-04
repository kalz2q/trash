#include <stdio.h>

int main(void) {
  char neta;

  printf("いらっしゃい！　何にしましょうか？\n");
  printf("a: とろ, b: 赤身, c: ホタテ, d: げそ >");
  scanf("%c", &neta);

  switch (neta){
  case 'a':
    printf("へい！　とろいっちょ！\n");
    break;
  case 'b':
    printf("はいよー！　赤身おまちどうさま。\n");
    break;
  case 'c':
    printf("ごめんねー、ホタテきらしてるんだ。\n");
    break;
  case 'd':
    printf("げそなんて、お客さんめずらしいねー。\n");
    break;
  default:
    printf("冷やかしなら帰ってもらうよー！\n");
    break;
  }
}

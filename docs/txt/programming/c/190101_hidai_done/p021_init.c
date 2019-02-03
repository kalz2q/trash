#include <stdio.h>
#define MONTHS 12

int main(void) {
  int day[MONTHS + 1] = {0,  31, 28, 31,
                         30, 31, 30, 31,
                         30, 31, 30, 31};
  int input;

  printf("今日は何月ですか？　>");
  scanf("%d", &input);
  printf("すると今月は%d日までだから、", day[input]);
  if (day[input] == 31) {
    // 「株式会社ダイクマは、神奈川県を中心にディスカウントストアを展開
    // していた企業。2013年6月1日に株式会社ヤマダ電機に吸収合併された。」
    printf("月末にはダイクマへ行きましょう\n");
  } else {
    printf("サーティーワンの日はないのですね\n");
  }
}

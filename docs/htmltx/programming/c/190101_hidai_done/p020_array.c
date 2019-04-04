#include <stdio.h>
#define MAX 5

int main(void) {
  int i;
  int point[MAX];
  int total = 0;
  int avr;  // average

  for (i = 0; i < MAX; i++) {//各生徒の得点をキーボードから得る。
    printf("%d人目の点数は？ >", i + 1);
    scanf("%d", &point[i]);
  }
  for (i = 0; i < MAX; i++) {
    printf("%d人目 = %d\n", i + 1, point[i]);//生徒i+1の得点を出力する。
    total += point[i];                       //総和を求める。
  }
  avr = total / MAX;//端数を切り捨てる。
  printf("平均点 = %d\n", avr);
}

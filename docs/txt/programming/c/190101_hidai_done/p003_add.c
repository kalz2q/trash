#include <stdio.h>

int main(void) {
  double radius = 10;   //半径
  double pi = 3.1415926;//π
  double circumference; //円周
  double area;          //面積

  circumference = radius * 2 * pi;
  area = radius * radius * pi;

  printf("半径 = %f\n", radius);
  printf("円周 = %f\n", circumference);
  printf("面積 = %f\n", area);
  printf("\n");
  printf("半径 = %f\n", radius = 20);
  printf("円周 = %f\n", radius * 2 * pi);
  printf("面積 = %f\n", radius * radius * pi);
}

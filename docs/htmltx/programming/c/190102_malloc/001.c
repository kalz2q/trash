#include <stdio.h>
#include <stdlib.h>
struct S { int n; char* s; };
int main(void) {
  struct S* s;
  s= (struct S*) malloc( sizeof(struct S) );
  s->n = 123;
  s->s = (char*) malloc( 32*sizeof(char) );
  sprintf(s->s, "%s %s", "hello", "world");
  printf("%d %s\n", s->n, s->s);
  free(s->s); free(s);
}

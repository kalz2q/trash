#include <algorithm>
#include <iostream>
using namespace std;
static const int MAX = 200000;  // 200,000

int main() {
  int R[MAX];
  int n;

  cin >> n;
  for (int i = 0; i < n; i++) {
    cin >> R[i];
  }
  int maxv = -2000000000;  // max value. 最大の儲け。-2,000,000,000
  int minv = R[0];         // iより前での最小値。
  for (int i = 1; i < n; i++) {
    maxv = max(maxv,
               R[i] - minv);
    minv = min(minv, R[i]);
  }
  cout << maxv << endl;
  return 0;
}

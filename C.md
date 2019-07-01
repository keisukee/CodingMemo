# ポインタ配列
```
プロトタイプ宣言
void hoge(int**);

int *poles[3]; // ポインタ配列

from = (int *)malloc(sizeof(int) * n);
current = (int *)malloc(sizeof(int) * n);
dest = (int *)malloc(sizeof(int) * n);

poles[0] = from;
poles[1] = current;
poles[2] = dest;

関数宣言
void hoge(int **poles) {
  printf("%p\n", poles[0]); // 0x7ffd5c500450
  printf("from = %p\n", from); // from = 0x7ffd5c500450
  printf("%p\n", poles[1]); // 0x7ffd5c500430
  printf("current = %p\n", current); // current = 0x7ffd5c500430
  printf("%p\n", poles[2]); // 0x7ffd5c5015b0
  printf("dest = %p\n", dest); // dest = 0x7ffd5c5015b0
}

```

# 動的配列 malloc
入力などによって配列の長さを変えたいとき
```
scanf("%d", &n);
int length = n;

int *from;
int *current;
int *dest;
int *poles[3];

from = (int *)malloc(sizeof(int) * n);
current = (int *)malloc(sizeof(int) * n);
dest = (int *)malloc(sizeof(int) * n);
```

# 配列のコピー
```
#include <string.h>
char name[256];
char minBMIPerson[256];
  name = "John Doe";
  strcpy(minBMIPerson, name);
```

# 再帰 ハノイの塔
```
// lengthは配列を表示するための数字。nは与える配列の長さ。なぜlengthとnを分けるかと言うと、hanoiの中でprint_hanoiを呼び出しているため、print_hanoiの引数にnを当ててしまうと再帰によってnが小さくなっていき表示される配列の部分が短くなっていくから
void hanoi(int length, int n, int *from, int *current, int *dest, int **poles) {
  int i = 0;
  if (n > 0) {
    hanoi(length, n-1, from, dest, current, poles);
    int temp;
    for (i = 0; i < length; i++) {
      if (from[i] != -1) {
        temp = from[i];
        from[i] = -1;
        break;
      }
    }

    for (i = length-1; i >= 0; i--) {
      if (dest[i] == -1) {
        dest[i] = temp;
        break;
      }
    }
    // from, current, destのアドレスを引数に渡している。こうしないと、再帰呼出しされた際に、hanoi()の中の3つの配列の順番が変わると表示の順番も変わってしまうため
    print_hanoi(length, poles[0], poles[1], poles[2]);
    hanoi(length, n-1, current, from, dest, poles);
  }
}
```

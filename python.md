# 文字列
word = "Python"
word[0] = "P"
word[-2] = "o"
word[0:2] = "Py" (0 is included, but 2 is excluded)

文字列は変更できない(immutable)

# 文字列 配列 長さ
s = 'supercalifragilisticexpialidocious'
len(s)
34

# リスト
squares = [1, 4, 9, 16, 25]
squares
[1, 4, 9, 16, 25]

リストは可変なので要素を入れ替え可能
squares[1] = 8
squares
[1, 8, 9, 16, 25]
長さも測れる
len(squares) -> 5

# if
f x < 0:
...     x = 0
...     print('Negative changed to zero')
... elif x == 0:
...     print('Zero')
... elif x == 1:
...     print('Single')
... else:
...     print('More')

# for
words = ['cat', 'window', 'defenestrate']
for w in words:
    print(w, len(w))
...
cat 3
window 6
defenestrate 12

# while
a, b = 0, 1
while a < n:
    print(a, end=' ')
    a, b = b, a+b

# range 反復
range(0, 5) -> [0, 1, 2, 3, 4]
連続なリストを生成
for文などに使う

for i in range(5)
print(i)

0
1
2
3
4

# if continue
コロンに注目
    for num in range(2, 10):
...     if num % 2 == 0:
...         print("Found an even number", num)
...         continue
...     print("Found a number", num)

# コーディングスタイル・規約
- インデントには空白 4 つを使い、タブは使わないこと

# リスト型 メソッド
- list.append(x)
- list.insert(i,x) i番目にxを割り込ませる
- list.remove(x) xに等しい最初の要素を削除
- list.count(x) xの出現回数をカウント
- list.sort(key=None, reverse=False) 昇順
- list.reverse() 降順
- list.copy() コピーを返す

# import

# print
print("平均: %d, 分散: %d" % (avg, variance))
もしくは、
print("平均: " + format(avg))

string型の場合はそのまま結合できる

# 標準入力
avg = int(input())

# 正規分布
平均 50, 標準偏差 10 の正規乱数を10000件生成
x = np.random.normal(50, 10, 10000)

# 計算
## 平方根
import math
math.sqrt(x)
もしくは、
import numpy
numpy.sqrt(9)

# error AttributeError: module 'sympy' has no attribute 'symbols'
が出たとき
1. ファイル名とimportするライブラリー名が重複していないか
2. pathは通っているか、正しいpathを参照しているかß

# 正規分布 累積密度関数 確率分布関数 グラフ描写
## 正規分布パターン1
import numpy as np

pi = np.pi
e = np.e

x = np.arange(-10, 10, 0.1)
y = (1/(np.sqrt(2*pi))) * e**(-x**2/2)

## 正規分布パターン2 scipy.statsを使用
```
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm
from math import *

x = np.arange(-100, 200, 0.1) # 1500～3000の要素が入ったリストを作る
data_sets = [[50, 10],[50, 50],[50, 100], [50, 500], [50, 1000]]
for data in data_sets:
    plt.figure()
    y = norm.pdf(x, loc=data[0], scale=sqrt(data[1])) # 平均40，標準偏差10の正規分布の累積分布関数
    plt.plot(x, y)
    plt.savefig("pdf_avg=%d_var=%d.png" % (data[0], data[1]))

```
## 累積密度関数
math.erf(x) 誤差関数を返す
 (1.0 + erf(x / sqrt(2.0))) / 2.0  累積標準正規分布を計算する関数
# 積分
import sympy as sym
x = sym.symbols('x')
p = sym.integrate(y, (x, -1, 1))

# グラフサンプル
`

import numpy as np
import matplotlib.pyplot as plt

# (x1, y1)のデータセットを作成
x1 = np.arange(-3.14, 3.14, 0.25)
y1 = np.sin(x1)

# (x2, y2)のデータセットを作成
x2 = np.linspace(0, 3, 10)  # xの値域：0-3、10分割
y2 = x2 + 1               # 直線の式

# プロット
plt.plot(x1, y1, "r-",lw=2, alpha=0.7, ms=2,label="(x1, y1)") # 線プロット
plt.plot(x2, y2, "bo",lw=2, alpha=0.7, ms=5,label="(x2, y2)") # 点プロット

# グラフ設定
```
plt.rcParams['font.family'] = 'Times New Roman' # 全体のフォント
plt.rcParams['font.size'] = 20                  # フォントサイズ
plt.rcParams['axes.linewidth'] = 1.0    # 軸の太さ
plt.legend(loc=2,fontsize=20)           # 凡例の表示（2：位置は第二象限）
plt.title('Graph Title', fontsize=20)   # グラフタイトル
plt.xlabel('x', fontsize=20)            # x軸ラベル
plt.ylabel('y', fontsize=20)            # y軸ラベル
plt.xlim([-3, 3])                       # x軸範囲
plt.ylim([-2, 4])                       # y軸範囲
plt.tick_params(labelsize = 20)         # 軸ラベルの目盛りサイズ
plt.xticks(np.arange(-3.0, 4.0, 1.0))   # x軸の目盛りを引く場所を指定（無ければ自動で決まる）
plt.yticks(np.arange(-3.0, 4.0, 1.0))   # y軸の目盛りを引く場所を指定（無ければ自動で決まる）
plt.axis('scaled')                      # x, y軸のスケールを均等
plt.tight_layout()                      # ラベルがきれいに収まるよう表示
plt.grid()                              # グリッドの表示
plt.show()                              # グラフ表示
```
# 累積分布関数
```

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm
from math import *

x = np.arange(0, 100, 0.1) # 1500～3000の要素が入ったリストを作る
data_sets = [[50, 10],[50, 50],[50, 100], [50, 500], [50, 1000]]
for data in data_sets:
    plt.figure()
    y = norm.cdf(x, loc=data[0], scale=sqrt(data[1])) # 平均40，標準偏差10の正規分布の累積分布関数
    plt.plot(x, y)
    plt.savefig("cdf_avg=%d_var=%d.png" % (data[0], data[1]))

```

# 多次元配列 for ループ 2次元配列
data_sets = [[50, 10],[50, 50],[50, 100], [50, 500], [50, 1000]]
for data in data_sets:
    data[0] <- data_sets[i]、つまり、配列がdataに入る
    data[1]

# クラスを調べる
type(x)で調べられる

# for文注意点
```
for i in x:
    print(i)
    if float(40) < x[i] < float(60):
        ctr.append(x[i])
```
上記のコードでは、各回のループでは、iはindexを指すと思っていたがpythonでは違うらしい。iに入るのは、実際のx[i]の数字。
だから、1..100のようにしたいのなら、

```
for i in range(0..100):
    print(i)
    if float(40) < x[i] < float(60):
        ctr.append(x[i])
```
としなければならない。

# ベンチマークを測る
ファイル全体の時間を測定する方法
`time python script.py`
でいける

# if break
二重for文の中から脱出したいときなど
```
for i in range(0, 100): # 100はデータの分割個数
    data_list.append([])
    for j in range(0, sample_amount):
        if i <= x[j] <= i + 1:
            data_list[i].append(x[j])
        elif x[j] > i + 1:
            break
```
でbreakできる

# math log sin cos e sqrt 数学計算
import math

math.log(x)
math.cos(x)

import numpy as np
np.e
np.pi
np.sqrt(x)

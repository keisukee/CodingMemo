# package, exported names
```
package main

import (
	"fmt"
	"math"
)

func main() {
	fmt.Println(math.Pi)
}
```

# 型宣言 省略
```
x int, y int
は
x, y int
にできる。同じ型の変数が連続して宣言される場合。
```

# 関数の返り値
```
string型の返り値が二つ
func swap(x, y string) (string, string) {
	return y, x
}
```

# named return values
```
関数の最初で、関数の返り値の名前を宣言した場合、ただのreturnは、宣言した変数を返す
func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}
```

# var 宣言
```
複数の変数を同時に宣言する場合はvarを使う
var c, python, java bool

func main() {
	var i int
	fmt.Println(i, c, python, java)
}
```

# := 暗黙的型宣言 implicit type declarations
```
:= は関数の内部でしか使えない
k := 3は、var k int = 3と同値
func main() {
	var i, j int = 1, 2
	k := 3
	c, python, java := true, false, "no!"

	fmt.Println(i, j, k, c, python, java)
}
```

# 初期値なしの変数
Variables declared without an explicit initial value are given their zero value.

The zero value is:

0 for numeric types,
false for the boolean type, and
"" (the empty string) for strings.

# 型変換
```
The expression T(v) converts the value v to the type T.

Some numeric conversions:

var i int = 42
var f float64 = float64(i)
var u uint = uint(f)
Or, put more simply:

i := 42
f := float64(i)
u := uint(f)
```

# 定数
```
const World = "世界"
fmt.Println("Hello", World)

> Hello 世界
```

# for文
```
for i := 0; i < 10; i++ {
    sum += i
}
```

## for文で繰り返し処理
```
func main() {
    sum := 1
    for ; sum < 1000; {
        sum += sum
    }
    fmt.Println(sum)
}
```

## 無限ループ
```
for {
    # ループ条件を省略すれば無限ループになる
}
```

## range
```
var pow = []int{1, 2, 4, 8, 16, 32, 64, 128}
for i, v := range pow {
    fmt.Printf("2**%d = %d\n", i, v)
}
```

## range _ アンダーバー 値を捨てる
```
もしインデックスだけが必要なのであれば、 " , value " を省略

pow := make([]int, 10)
for i := range pow {
    pow[i] = 1 << unit(1)
}
for _, value := range pow {
    fmt.Printf("%d\n", value)
}
>
1
2
4
8
16
32
64
128
256
512
```

# if
```
func sqrt(x float64) string {
    if x < 0 {
        return sqrt(-x) + "i"
    }
    return fmt.Sprint(math.Sqrt(x))
}
```

## if 評価するまえのステートメント
```
	if v := math.Pow(x, n); v < lim {
		return v
	}
```

# switch
```
func main() {
	fmt.Print("Go runs on ")
	switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("OS X.")
	case "linux":
		fmt.Println("Linux.")
	default:
		// freebsd, openbsd,
		// plan9, windows...
		fmt.Printf("%s.", os)
	}
}
```

# defer 遅延
```
defer ステートメントは、 defer へ渡した関数の実行を、呼び出し元の関数の終わり(returnする)まで遅延させるもの

func main() {
	defer fmt.Println("world")

	fmt.Println("hello")
}

> hello world
```

## defer stack
```
関数を複数deferにわたすと、LIFO(last-in-first-out）形式で実行される

func main() {
	fmt.Println("counting")

	for i := 0; i < 10; i++ {
		defer fmt.Println(i)
	}

	fmt.Println("done")
}

>
counting
done
9
8
7
6
5
4
3
2
1
0
```

# ポインタ演算
```
	i, j := 42, 2701

	p := &i         // point to i
	fmt.Println(*p) // read i through the pointer
	*p = 21         // set i through the pointer
	fmt.Println(i)  // see the new value of i

	p = &j         // point to j
	*p = *p / 37   // divide j through the pointer
	fmt.Println(j) // see the new value of j

>
42
21
73
```

# 構造体
```
type Vertex struct {
	X int
	Y int
}

func main() {
	fmt.Println(Vertex{1, 2})
}
```

# structのフィールドへのアクセス
```
type Vertex struct {
	X int
	Y int
}

func main() {
	v := Vertex{1, 2}
	p := &v
	p.X = 1e9 # (*p).Xでもアクセスできる
	fmt.Println(v)
}

> {1000000000 2}
```

# 配列 固定長
```
var a [2]string
a[0] = "hello"
a[1] = "world
fmt.Println(a[0], a[1])
fmt.Println(a)

>
Hello World
[Hello World]

primes := [6]int{2, 3, 5, 7, 11, 13}
fmt.Println(primes)
> [2, 3, 5, 7, 11, 13]
```

# スライス 可変長
a[low : high] 二つのインデックスの境界を指定することでスライスが形成される
```
primes := [6]int{2, 3, 5, 7, 11, 13}
var s []int = primes[1:4]
fmt.Println(s)

> [3 5 7]
```

## スライスはもとの配列の部分列
```
names := [4]string{
    "John",
    "Paul",
    "George",
    "Ringo",
}
fmt.Println(names)
> [John Paul George Ringo]

a := names[0:2]
b := names[1:3]
fmt.Println(a, b)
> [John Paul] [Paul George]
b[0] = "X"
fmt.Println(a, b)
> [John XXX] [XXX George]
fmt.Println(names)
> [John XXX George Ringo]
```

## スライス記法
```
s := []int{2, 3, 5, 7, 11, 13}
s = s[:2]
fmt.Println(s)
> [3 5]
s = s[1:]
fmt.Println(s)
> [5]
```

## slice 長さ(length) 容量(capacity)
```
func main() {
	s := []int{2, 3, 5, 7, 11, 13}
	printSlice(s)
    > len=6 cap=6 [2 3 5 7 11 13]

	// Slice the slice to give it zero length.
	s = s[:0]
	printSlice(s)
    > len=0 cap=6 []

	// Extend its length.
	s = s[:4]
	printSlice(s)
    > len=4 cap=6 [2 3 5 7]

	// Drop its first two values.
	s = s[2:]
	printSlice(s)
    > len=2 cap=4 [5 7]
}

func printSlice(s []int) {
	fmt.Printf("len=%d cap=%d %v\n", len(s), cap(s), s)
}
```

# スライスのゼロ値
スライスのゼロ値はnil
```
var s []int
fmt.Println(s, len(s), cap(s))
> [] 0 0
if s == nil {
    fmt.Println("nil!")
}
> nil!
```

# スライスを作成 make
```
b := make([]int, 0, 5) // len(b)=0, cap(b)=5

b = b[:cap(b)] // len(b)=5, cap(b)=5
b = b[1:]      // len(b)=4, cap(b)=4
```

# スライスへ要素を追加 append
```
	var s []int
	printSlice(s)

	// append works on nil slices.
	s = append(s, 0)
	s = append(s, 3)
    fmt.Println(s)
> [0 4]
```

# map
```
m へ要素(elem)の挿入や更新:

m[key] = elem
要素の取得:

elem = m[key]
要素の削除:

delete(m, key)
キーに対する要素が存在するかどうかは、2つの目の値で確認します:

elem, ok = m[key]
もし、 m に key があれば、変数 ok は true となり、存在しなければ、 ok は false
```

# 書式
```
%T: 対象データの型情報を埋め込む
%v: デフォルトフォーマットで対象データの情報を埋め込む
%+v: 構造体を出力する際に、%vの内容にフィールド名も加わる
%#v: Go言語のリテラル表現で対象データの情報を埋め込む
%q: 対応する文字をシングルクォート'で囲んだ文字列
```

# 型アサーション
```
t := i.(T)
```

# goroutine

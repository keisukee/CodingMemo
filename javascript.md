# HTML上で読み込む
## 内部で
```
<script type = "text/javascript">
  // ここにコードを書く
</script>
```
## 外部で
```
<script src = "JavaScriptのファイルパス" > </script>
```

# コンソール
`console.log('Hello World');`

# アラート
`alert("Hello World!!");`

# var let
- letは一回のみしか宣言できない
- varは重複して宣言できる

# 定数
```
const TAX = 1.10
```

# 配列
```
var array = [1, 2, 3, 4, 5, "six", "seven"]
array[0] -> 1
array[5] -> "six"
```

# オブジェクトリテラル
```
var hash = {a:1, b:2, c:3}
hash["a"] -> 1
```

# 演算子
```
1 === 1 -> true
1 == 1 -> true
a = 1
a += 1 ->2
a === 2 -> true

1 == true -> true
1 === true -> false
```

## 等価演算子
`1 == true -> true`

## 同値演算子
`1 === true -> false`

## 条件演算子
```
x >= 70 ? "合格" : "不合格" -> "合格"
x == 70 ? "合格" : "不合格" -> "不合格"
```
# ショートカット演算（短絡演算）
```
if (x === 1) { console.log("hello"); } -> hello
x === 1 && console.log("hello"); -> hello // 右辺の値がそのまま返ってくる
```

# delete
```
var array = [0,1,2,3,4,5]
delete array[2] -> true
array ->[0, 1, empty, 3, 4, 5]
array[2] -> undefined
array[1] -> 1
array[2] = 20
array -> [0, 1, 20, 3, 4, 5]
```

# typeof
```
var num = 1 ->undefined
typeof num -> "number"
str = "konn" -> "konn"
typeof str -> "string"
typeof "aaa" -> "string"
```

# if else
```
var x = 30;
if (x >= 20) {
  console.log("x is more than 20");
} else if (x >= 10) {
  console.log("x is more than 10");
} else {
  console.log("x is less than 10");
}
```

## 省略
ブロックの中が1文なら省略できる
```
var x = 30;
if (x >= 20)
  console.log("x is more than 20");
else if (x >= 10)
  console.log("x is more than 10");
else
  console.log("x is less than 10");
```

# switch
switch文は`===`で処理されることの注意
```
var rank = 'B';
switch(rank) {
  case 'A':
    console.log("A rank");
    break;
  case 'B':
    console.log("B rank");
    break;
  case 'C':
    console.log("C rank");
    break;
  default:
    console.log("ランク外");
    break;
}
```

# while, do while
```
var x = 8;
while(x < 10) {
  console.log('x = ' + x);
  x++;
}

do {
  console.log('x = ' + x);
  x++;
} while(x < 10); // do~whileの場合は、最後のwhileのあとにセミコロンが必要
```

# for
```
for (var x = 8; x < 10; x++) {
  console.log("x = " + x);
}
```

# 連想配列
```
var data = { apple:150, orange:100, banana:120 };
for (var key in data) {
  console.log(key + '=' + data[key])
}
```

# ループを途中でスキップ・中断
```
var result = 0;
for (var i = 0; i <= 100; i++) {
  result += i;
  if (result > 1000) { break; }
  if (i % 2 == 0) { continue; }
}
```

# 例外を処理
```
var i = 1;
try{
  i = i * j;
} catch(e) {
  console.log(e.message);
} finally {
  console.log("処理は完了しました");
}
```

# 関数
```
function getTriangle(base, height) {
  return base * height / 2;
}
console.log(getTriangle(2, 5));
```

## コンストラクター経由
```
var getTriangle = new Function('base', 'height', 'return base * height / 2;');
```

## 関数リテラル表現
```
var getTriangle = function(base, height) {
  return base * height / 2;
};
```

## アロー関数
```
let getTriangle = (base, height) => {
  return base * height / 2;
}

let getTriangle = (base, height) => base * height / 2; // 一行の場合はブロックを省略できる
let getCircle = radius => radius * radius * Math.PI; // 引数が一つの場合はカッコを省略できる
```

# 引数のデフォルト値
```
function getTriangle(base = 1, height = 1) {
  return base * height / 2;
};
```
# クロージャー
```
function closure(init) {
  var counter = init;
  return function() {
    return ++counter;
  }
}

var myClosure1 = closure(1);
var myClosure2 = closure(100);
```

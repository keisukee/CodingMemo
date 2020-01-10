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

## アロー関数 arrow function
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
# 時間差処理
```
setTimeout(function(){ alert("Hello"); }, 3000);
```

# 無限ループ
```
function timeout() {
  setTimeout(function () {
    distance += 10;
    move(distance);
    timeout();
  }, 50);
}
```

# class extends クラス継承
```
class Human {
  constructor() {
    this.gender = 'male';
  }

  printGender() {
    console.log(this.gender);
  }
}

class Male extends Human {
  constructor() {
    super();
    this.name = 'max';
    this.gender = 'female';
  }

  printName() {
    console.log(this.name);
  }
}

クラスを継承するとき、子クラスでconstructorを使うときは、必ず一番最初にsuper()を呼び出さないといけない
```

# ES6/ES7
ES6系の書き方
```
class Human {
  constructor() {
    this.gender = 'male';
  }

  printGender() {
    console.log(this.gender);
  }
}

class Male extends Human {
  constructor() {
    super();
    this.name = 'max';
    this.gender = 'female';
  }

  printName() {
    console.log(this.name);
  }
}

```

ES7系の書き方
```
class Human {
  gender = 'male';

  printGender = () => {
    console.log(this.gender);
  }
}

class Male extends Human {
  name = 'max';
  gender = 'female';

  printName = () => {
    console.log(this.name);
  }
}

```

# ... spread, rest
spread
```
const array1 = [1, 2, 3];
const array2 = [...array1, 4, 5]; // [1, 2, 3, 4, 5]になる
```
rest
```
const fileter = (...args) => {
  return args.filter(el => el === 1);
}

console.log(filter(1, 2, 3)); // [1]
```

# destructuring
```
const numbers = [1, 2, 3];

[num1, , num3] = numbers;
console.log(num1, num3); // 1, 3
```

# 参照渡しと値渡し reference and primitive types refresher
```
let a = 10;
let b = a;
a = 11; // a = 11, b = 10

let person = {name: 'hoge'};
let person2 = person;
person.name = 'fuga'; // person2も{name: 'fuga'}になる→person2に入っているのはポインターであり、person.nameはpersonが参照している先

let person3 = {
  ...person;
}

// person3はpersonのプロパティだけを完全にコピーしたオブジェクト。

```

# innerHTML, innerText, valueの違い
Setting the value is normally used for input/form elements. innerHTML is normally used for div, span, td and similar elements.

value applies only to objects that have the value attribute (normally, form controls).

innerHtml applies to every object that can contain HTML (divs, spans, but many other and also form controls).

# setTimeout
```
function updateTimer(timer, startTime) {
  setTimeout(function() {
    if (isRunning === true) {
      return;
    }
    timer.innerHTML = setTime(startTime);
    updateTimer(timer, startTime);
  }, 10);
}
```
import UIKit

var str = "Hello, playground"
1+2
10-1
10*2
10/3
10%3
"こんにちは"
"Hello, " + "Playground"

print("Hello Playground yahooooooo")

var value: String = "Hello, playground called from var value"
var hoge = "型推論天才すぎぃ！"
print(value)
print(hoge)
value = "changed"
print(value)
let constant_value: String = "Hello, playground called from let constant value" // let で定数が宣言できる
print(constant_value)

var a = 10
var aString = String(a)
value = "りんごを" + aString + "個買いました"
print(value)
var value1_1: Int = Int.max
var value1_2: Int = Int.min
var value2_1: Int8 = Int8.max
var value2_2: Int8 = Int8.max
var value3_1: Int16 = Int16.max
var value3_2: Int16 = Int16.min


var valuef1_1: Float = 12.34
var valuef1_2: Float = -12.34
var valued2_1: Double = 123.45
var valued2_2: Double = -123.45

print("aaa")

// 整数を浮動小数点に変換
//let value1 = 3
//let value12 = 0.14159
//let pi = Double(value1) + value12
//print(pi)

//print(Int(pi))
// ミュータブル（可変）な配列
var array1: [String] = [String]()
array1.append("りんご")
array1.append("ごりら")

// イミュータブル（不変）な配列
let array2: [String] = [String]()
//array2.append("りんご") // これはエラーになる
let array3: [String] = ["りんご", "ごりら", "らっぱ"]

print(array3)
print(array3[0])
print("array3[1] = " + array3[1])

// 辞書
// ミュータブルな辞書
var dic1: [String:String] = [String:String]()
dic1["りんご"] = "1個"
dic1["ごりら"] = "1匹"

// イミュータブルな辞書
let dic2: [String:String] = [String:String]()
//dic2["りんご"] = "1個" これはエラーになる

// イミュータブルの宣言例
let dic3: [String:String] = ["りんご":"1個", "ごりら":"1匹"]

// Optional型: 値が存在しないかもしれない状態を持つ型
var op_value: String?
op_value = "こんにちは"
//print(op_value ?? <#default value#>)
if let op_value = op_value { // アンラップ処理
    print(value)
}

// アンラップ処理後の変数を利用しない場合はアンダーバーで省略することができる
var op_value2: String?
op_value2 = "こんにちは2"
if let _ = op_value2 {
    print("valueはnilではない")
}

// アンラップ前と後の変数名は統一すべし
//var value: String?
//value = "こんにちは"
//if let unwrappedValue = value {
//    print(unwrappedValue)
//}

// 関数

// 戻り値つきの関数
func myFunc(value: Int) -> Int {
    var resultValue: Int = 0
    resultValue += 1
    return resultValue
}

myFunc(value: 0)
print(myFunc(value: 0))

// 引数なし
func myFunc2() {
    // some processing
}

// 引数あり
func myFunc3(value: Int) {
    // some processing
}

// 引数を指定して関数呼び出し
// myFunc3(value: 10)

// 引数の意味をわかりやすくさせる
func showTestScore(mathematicsTestScore: Int) -> String {
    return "数学の点数は\(mathematicsTestScore)点"
}

// 引数に別名を指定。こうすると、関数の処理内部で引数を何回も呼び出すときに、記述量が減って楽
func showTestScore2(mathematicsTestScore score: Int) -> String {
    return "数学の点数は\(score)点"
}
showTestScore2(mathematicsTestScore: 10)

// 引数名の省略
func addValue(_ value: Int) {
    // some processing
}

// 関数呼び出し時に引数名を省略できる
addValue(100)

// エラーを通知するthrow処理

// エラータイプ宣言
enum MyError: Error {
    case InvalidValue
}

// エラーをthrowする可能性のある
func doubleUp(value: Int) throws -> Int {
    if value < 0 {
        throw MyError.InvalidValue
    }
    return value * 2
}

// エラーをthrowする関数を呼び出すときには、do-try-catch文で囲む必要がある
// エラーハンドリングが必要なdoubleUp関数を利用
do {
    try doubleUp(value: 10) // try句を付ける必要がある
    print("正常終了")
} catch MyError.InvalidValue {
    print("エラー発生")
}

func longMethod() throws {
    // 時間のかかる処理
}
do {
    print("処理開始時間: \(Date())")
    try longMethod() // try句をつける必要がある
    print("処理終了時間: \(Date())")
} catch {
    print("エラー発生")
}


// 処理終了時に必ず行う処理 defer
do {
    defer {
        print("処理終了時間: \(Date())")
    }
    print("処理開始時間: \(Date())")
    try longMethod()
} catch {
    print("エラー発生")
}

// クラスのインスタンス化
var radio = UISwitch()
radio.isOn = true
//radio.isOn = false

// インスタンスメソッド
radio.setOn(false, animated: false)

// 独自クラス
class Dog {
    // プロパティ, メソッドを記述
    var name = "" // プロパティ
    var type = ""
    var birthday = ""

    func bark() { // メソッド
        print("bowbow")
    }
}

var dog = Dog()
dog.name = "caesar"
dog.bark()

// クラスの継承、メソッドのオーバーライド
class GuideDog: Dog {
    var age = ""
    override func bark() {
        print("waooooooo")
    }
}

var guideDog = GuideDog()
guideDog.age = "10"
guideDog.bark()
print(guideDog.age)


// クラスと構造体の違い: クラスは常に参照渡し、構造体は常にコピーした値渡し

// 構造体
struct MyStruc {
    var value: String?
    func some_method(value: Int) -> Int {
        var resultValue: Int = 0
        resultValue += 100
        return resultValue
    }
}


// enumとは: 列挙した値を管理するのに最も適した型

enum Fruit {
    case Apple
    case Orange
}

// タプル（Tuple）: 複数の値を一組にまとめる
func requestMinAndMax() -> (min: Int, max: Int) {
    // 値はタプルで返却
    return(1, 100)
}
let minANdMax = requestMinAndMax()
let minValue = minANdMax.min // minAndMax.0でも取り出し可能
let maxValue = minANdMax.max // minAndMax.1でも取り出し可能

// for文, 0...9は0から9まで。0..<9は0から
for index in 0...9 {
    print("index:\(index)")
}

// カウンタの数字を利用しない場合
for _ in 0..<9 {
    print("index")
}

// 配列を利用した繰り返し処理
let values = ["abc", "def", "ghi"]
for value in values {
    print(value)
}

for (index, value) in values.enumerated() {
    print("\(index): \(value)")
}

// if文
let value2 = 5
if value2 < 10 {
    print("valueが10より小さいです")
} else {
    print("valueが10以上です")
}

// if-else-if
let value3 = 101
if value3 < 10 {
    print("valueが10より小さいです")
} else if value3 > 100 {
    print("valueが100より大きいです")
} else {
    print("どちらでもない")
}

// switch文
let value4 = 100
switch value4 {
case 0:
    print("valueが0のとき")
case 1...100:
    print("valueが1~100のとき")
default:
    print("上記以外")
}

// enum値を利用した例
enum Fruit2 {
    case Apple
    case Orange
}

let value5 = Fruit2.Orange
switch value5 {
case .Apple:
    print("Apple")
case .Orange:
    print("Orange")
}

// 一致しなかったcase文の内容も実行したい場合: fallthroughを使う
let value6 = "りんご"
switch value6 {
case "りんご":
    print("りんごです")
    fallthrough
case "みかん":
    print("みかんです")
default:
    print("どちらでもない")
}

// while文
var while_count = 1
var while_result = 0
while while_count <= 10 {
    while_result += while_count
    while_count += 1
}

print("合計は\(while_count)")

// guard文: 変数のチェックを明示的に記述
func buyItem(myMoney :Int?) {
    guard let money = myMoney else {
        return
    }
    print("所持金\(money)円で商品を購入します")
}

// 配列に対して条件付で絞り込みを行う。filterの引数は$0で表すこともできる
var filter_values = [11, 4, 25, 16, 5]
let filter_results = filter_values.filter { (x:Int) -> Bool in
    // 10より小さい値にする
    if x < 10 {
        return true
    }
    return false
}
print(filter_results)

// map: 繰返し項目の値を変化させる
var map_values = [11, 4, 26, 16, 5]

//let map_results = map_values.map { (x:Int) -> Int in
//    return x * 2
//}
// 下の$0は上3行と等価
let map_results = map_values.map{$0 * 2}
print(map_results)

// reduce文
var reduce_values = [11, 4, 25, 16, 5]
let total = reduce_values.reduce(0) { (nowTotal:Int, value:Int) -> Int in
    return nowTotal + value
}
// let total = reduce_values.reduce(0){$0 + $1}

print(total)

// sort文
var sort_values = [11, 4, 25, 16, 5]
sort_values.sort { (value1:Int, value2:Int) -> Bool in
    value1 < value2
}

// sort_values.sort{$0 < $1}
print(sort_values)

// for-in-where（フィルタリング）
for value in 0..<9 where value != 5 {
    print("index\(value)")
}


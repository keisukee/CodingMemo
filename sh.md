# 形式
```
#!/bin/zsh
if [ $# == 1 ]; then
    rg --context 3 $1 ~/Programming/CodingMemo/
elif [ $# == 2 ]; then
    rg --context 3 $1 ~/Programming/CodingMemo | rg --context 3 $2
elif [ $# == 3 ]; then
    rg --context 3 $1 ~/Programming/CodingMemo | rg --context 3 $2 | rg --context 3 $3
fi
```

# エラーメッセージをフィルタリングして、成功結果だけを返す

find / -name "*docker" 2> /dev/null
/dev/nullに2>と指定すると、エラーメッセージを勝手に消去してくれる

# キーボードのキーが押されたかを確認する
```
document.onkeydown = function (e){
	if(!e) e = window.event; // レガシー

	// ------------------------------------------------------------
	// 入力情報を取得
	// ------------------------------------------------------------
	// キーコード
  var key_code = e.keyCode;
	// Shiftキーの押下状態
	var shift_key = e.shiftKey;
	// Ctrlキーの押下状態
	var ctrl_key = e.ctrlKey;
	// Altキーの押下状態
  var alt_key = e.altKey;
  
  if (key_code === 32) {
    console.log("space key is pushed");
  }

	// ------------------------------------------------------------
	// 出力テスト
	// ------------------------------------------------------------
	console.log("code:" + key_code);
	console.log("shift:" + shift_key);
	console.log("ctrl" + ctrl_key);
	console.log("alt:" + alt_key);
};
```

# HTML要素を挿入
```
insertAdjacentHTML()

var h = '<div class="inner_01">'
      + 'コンテンツ1'
      + '</div>'
      + '<div class="inner_02">'
      + 'コンテンツ2'
      + '</div>' 
      + '<div class="inner_03">'
      + 'コンテンツ3'
      + '</div>';
document.getElementById('wrap').insertAdjacentHTML('POSITION',h);
```

- beforebegin	親要素の直前に要素を挿入
- afterbegin	親要素配下の先頭の子要素の直前に要素を挿入
- beforeend	親要素配下の最後の子要素の直後に要素を挿入
- afterend	親要素の直後に要素を挿入

# 絶対値
Math.abs(number)

# 要素の追加
```
 // a 要素の作成と属性の指定
    var newAnchor = document.createElement("a");
    var newTxt = document.createTextNode( document.getElementById("favtext").value );
    newAnchor.appendChild( newTxt );
    newAnchor.setAttribute("href", document.getElementById("favurl").value );
    newAnchor.setAttribute("target", "_blanc" );

    // li 要素の作成
    var newLi = document.createElement("li");
    newLi.appendChild ( newAnchor );

    // リストに追加
    var list = document.getElementById("FavList");
    list.appendChild( newLi );
```
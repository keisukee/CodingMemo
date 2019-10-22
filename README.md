# CodingMemo
## How to use
自作のシェルスクリプトを使って、自作のメモの中から、探したいコードなどを一瞬でgrepできるように。

エイリアスを作成してターミナル内のどこからでも実行できるようにした。

```
sc $1 $2 $3
```

search codeの略でsc

引数は最大3つまで。引数を含んだ箇所を指定のディレクトリ下から取得してくる

ex)


```
$ sc add column

rails generate migration add_email_to_users(or AddEmailToUsers)

--
def change
  add_column :users, :email, :string
  add_column :accounts, :ssl_enabled, :boolean, default: true

  remove_column :titles, :place, :string
end
--
```
## About
プログラミングのメモを集積する。

各言語ごとだったり技術ごとで分類して、使うときになったら検索でボコッと持ってこれるように。

サンプルコードとか、定義とか、そういうのをまるごとコピってきて、ひたすら分類・集積。プログラミングコードをいちいち暗記なんてできないが、カンニングならいくらでもできる。

このメモはいわば最強のチートシートみたいなもの。これを見れば必要なことはだいたい書いてある、そういうメモにしたい。

例えば、Railsで新しいプロジェクトを立ち上げたい時、どういうコマンドを打てばいいのか、どのディレクトリーのどのファイルをいじればいいのか、などの知見をいちいちググっているのは時間の無駄だし、確実性がない。自分でやって上手く行ったものなら再現性があるし、何より速い。というわけでやっていく。

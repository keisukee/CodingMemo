SELECT name
FROM shoppinglist;

SELECT name,price
FROM shoppinglist;

SELECT *
FROM shoppinglist;

SELECT *
FROM shoppinglist
WHERE　price　= 100;

SELECT *
FROM shoppinglist
WHERE price <= 100;

「ある文字を含むデータ」を取得する場合、「〇〇のような」という意味を持つLIKE演算子を使う。
SELECT *
FROM shoppinglist
WHERE name LIKE "%納豆%";

SELECT *
FROM shoppinglist
WHERE NOT price = 100;

NULLのデータを取得
SELECT *
FROM shoppinglist
WHERE price IS NULL;

AND演算子
WHERE文に複数の条件を指定することができる。「WHERE 条件1 AND 条件2」のようにすることで、条件1と条件2を共に満たすデータを検索することが可能になる。

SELECT * FROM shoppinglist
WHERE name = "鶏肉"
AND price　= 300;

OR演算子
AND演算子と同様に複数の条件を扱う。「WHERE 条件1 OR 条件2」のようにすることで、条件1または条件2のどちらかを満たすデータを検索することができる。

SELECT * FROM shoppinglist
WHERE name = "鶏肉"
OR name　= "もやし";

ORDER BY
データを並び替えるには、順に並べるという意味の「ORDER BY」を使う。並べ方は、昇順(ASC)もしくは降順(DESC)を指定する。

SELECT * FROM shoppinglist
ORDER BY　price DESC;

LIMIT
「最大で何件取得するか」を指定するためには、「制限する」という意味の「LIMIT」を使う。「LIMIT」は左の図のように「データの件数」を指定する。

SELECT * FROM shoppinglist
LIMIT 3;

DISTINCT（重複データを省く）
検索結果から重複するデータを省くことが可能になる。「DISTINCT(カラム名)」とすることで、検索結果から指定したカラムの重複するデータを除くことができる。

SELECT DISTINCT(name)
FROM shoppinglist;

四則演算
SQLでは、足す(+)、引く(-)、かける(*)、割る(/)ができる。

↓例えば、買い物リストの各商品に消費税を入れる。

SELECT name,price * 1.08
FROM shoppinglist;

関数
SUM関数
数値の合計を計算する。

SELECT SUN(price)
FROM shoppinglist;

COUNT関数
指定したカラムのデータの合計数を計算する。
SELECT COUNT(name)
FROM shoppinglist;

MAX・MIN関数
最大(MAX)と、最小(MIN)を求める。

SELECT　name,MAX(price)
FROM shoppinglist;


GROUP BY(グループ化をする)
GROUP BYを用いると、データをグループ化することができます。例えば図のように「GROUP BY カラム名」とすることで、指定したカラムで、完全に同一のデータを持つレコードどうしが同じグループとなる。

SELECT　SUM(price),date
FROM shoppinglist
GROUP BY date;


HAVING（グループ化したデータを絞り込む）
GROUP BYでグループ化したデータを絞り込みたいとき使う。「WHERE」はグループ化される前のテーブル全体を検索対象とするが「HAVING」はGROUP BYによってグループ化されたデータを検索対象とする。

SELECT　SUM(price),date
FROM shoppinglist
GROUP BY date
HAVING　SUN(price)>500;

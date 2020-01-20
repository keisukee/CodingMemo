`drop: alter table users add index index_users_on_last_sign_in_at(last_sign_in_at)`
`create: alter table users drop index index_users_on_email;`

```mysql
drop: alter table users drop index index_users_on_uid_and_provider;
drop: alter table users drop index index_users_on_reset_password_token;
drop: alter table users drop index index_users_on_confirmation_token;
drop: alter table users drop index index_users_on_deleted_at;
```

```mysql
create: alter table users add index index_users_on_email(email);
create: alter table users add index index_users_on_uid_and_provider(uid, provider);
create: alter table users add index index_users_on_reset_password_token(reset_password_token);
create: alter table users add index index_users_on_confirmation_token(confirmation_token);
create: alter table users add index index_users_on_deleted_at(deleted_at);

```

# ログイン
`mysql -u root -p hogehoge (rootユーザー、パスワードはhogehogeでログインするという意味))`
# データベース一覧 db一覧
`> show databases;`
# データベース作成 db作成
`> CREATE DATABASE db_name;`
# データベース参照
`> use db_name;`
# テーブル操作
`> show tables;`
# テーブル参照
`> describe users;`
# mysqlで接続しているDBサーバのホスト名を確認する方法
`mysql> show variables like 'hostname';`
# drop 削除
`DROP {DATABASE | SCHEMA} [IF EXISTS] db_name`
`DROP DATABASE dup_pickup_lines;`
# ダンプ dump
## 基本的なオプション
オプション	意味	説明
-u	ユーザー名(user)	サーバに接続するユーザー名
-p	パスワード(password)	パスワードを指定してログイン
-h	ホスト名(host)	接続するサーバのホスト名(ex. localhost, 127.0.0.1)指定しないとlocalhostになる
-B	データベース(dababase)	複数のデータベースを名前を指定してダンプ
-A	すべてのデータベース(all)	複数のデータベースをまとめてダンプ
-d	定義のみ(no-data)	定義のみダンプを取りたいときに指定
-n	データベースは無視(no-create-db)	データベースを作成せずにダンプ
-t	テーブルは無視(no-create-info)	テーブルの作成を行わずにダンプ

## データベース
$ mysqldump -u USER_NAME -p -h HOST_NAME DB_NAME > OUTPUT_FILE_NAME
### テーブル
$ mysqldump -u USER_NAME -p -h HOST_NAME DB_NAME TABLE_NAME > OUTPUT_FILE_NAME
### テーブルの定義とデータのダンプ
$ mysqldump -u USER_NAME -p -h HOST_NAME -A -n > OUTPUT_FILE_NAME

## 複数のデータベース・テーブルのダンプ(定義とデータ)
### データベース
$ mysqldump -u USER_NAME -p -h HOST_NAME -B DB_NAME1 [DB_NAME2 ...] > OUTPUT_FILE_NAME
### テーブル
$ mysqldump -u USER_NAME -p -h HOST_NAME TABLE_NAME1 [TABLE_NAME2 ...] > OUTPUT_FILE_NAME

## 定義のみダンプ
### データベースとテーブル定義をダンプ
$ mysqldump -u USER_NAME -p -h HOST_NAME DB_NAME -d > OUTPUT_FILE_NAME
### データベースの定義のみダンプ
$ mysqldump -u USER_NAME -p -h HOST_NAME DB_NAME -d -t > OUTPUT_FILE_NAME
### テーブルの定義のみダンプ
$ mysqldump -u USER_NAME -p -h HOST_NAME DB_NAME -d -n > OUTPUT_FILE_NAME

## 全てのデータベース・テーブルの定義をダンプ
### データベースとテーブル
$ mysqldump -u USER_NAME -p -h HOST_NAME -A -d > OUTPUT_FILE_NAME
### データベース
$ mysqldump -u USER_NAME -p -h HOST_NAME -A -d -t > OUTPUT_FILE_NAME
### テーブル
$ mysqldump -u USER_NAME -p -h HOST_NAME -A -d -n > OUTPUT_FILE_NAME

## データのみのダンプ
### データベースのデータ
$ mysqldump -u USER_NAME -p -h HOST_NAME -t DB_NAME > OUTPUT_FILE_NAME
### テーブルのデータ
$ mysqldump -u USER_NAME -p -h HOST_NAME -t DB_NAME TABLE_NAME > OUTPUT_FILE_NAME
### 全てのデータ
$ mysqldump -u USER_NAME -p -h HOST_NAME -A -t > OUTPUT_FILE_NAME

## 出力ファイルの実行
出力したOUTPUT_FILE_NAMEをMySQLに反映させるには以下のコマンドを実行します
### 出力されたスクリプトファイルの実行
`$ mysql -u USER_NAME -p -h HOST_NAME DB_NAME < OUTPUT_FILE_NAME`
ex) `mysql -u root -p dup_pickup_lines < dump-pickup-lines-data`
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
```
mysql -u root -p hogehoge (rootユーザー、パスワードはhogehogeでログインするという意味))
```

# データベース一覧 db一覧
```
> show databases;
```

# データベース作成 db作成
```
> CREATE DATABASE db_name;
```

# データベース参照
```
> use db_name;
```

# テーブル操作
```
> show tables;
```

# テーブル参照
```
> describe users;
```
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
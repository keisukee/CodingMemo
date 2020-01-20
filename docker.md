# docker-compose.yml jessie アップデート問題の解決法
RUN apt の前に下のスクリプトをぶっこむといける。
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

# railsプロジェクトのサンプル
1. mkdir sampleApp
2. cd sampleApp
3. vim Dockerfileで

```Dockerfile
# コピペでOK, app_nameもそのままでOK
# 19.01.20現在最新安定版のイメージを取得
FROM ruby:2.5.3

# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \        
                       nodejs           

# 作業ディレクトリの作成、設定
RUN mkdir /app_name
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /app_name
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT
```
4. vim Gemfile
```Gemfile
source 'https://rubygems.org'
gem 'rails', '5.2.2'
```
5. touch Gemfile.lock
6. vim docker-compose.yml
```docker-compose.yml
version: '3'
services:
  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: root
    ports:
      - "3306:3306"

  web:
    build: .
    command: bundle exec rails s -p 3000 -b '0.0.0.0'
    volumes:
      - .:/app_name
    ports:
      - "3000:3000"
    links:
      - db
```

7. `docker-compose run web rails new . --force --database=mysql --skip-bundle --skip-test`
8. database.ymlを修正 -> vim config/database.yml
```database.yml
default: &default
  adapter: mysql2
  encoding: utf8
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password: password
  host: db

development:
  <<: *default
  database: app_name_development

test:
  <<: *default
  database: app_name_test

production:
  <<: *default
  database: app_name_production
  username: app_name
  password: <%= ENV['APP_NAME_DATABASE_PASSWORD'] %>

```
9. docker-compose build でビルド
10. docker-compose up -d -dをつけるとバックグラウンドで立ち上がるので便利
11. docker-compose run web rails db:create
12. localhost:3000で確認
13. docker-compose downでサーバーを停止。Ctrl + cだとエラーが起きる

補足情報としては、毎回docker-compose downするたびに、docker-compose up -d やdocker-compose run web rails db:createの設定が0に戻る。
つまり、downするたびに、docker-compose up -dから先は毎回やり直さないといけないということ。また、Dockerfileやdocker-compose.ymlの変更したらrailsサーバーを再起動しないといけない。

## bundle install などを実行したい場合
`docker-compose run web bundle install`

# コマンド一覧 チートシート
- `docker ps -a` ローカルで作られたコンテナ一覧が確認できる
- `docker rm コンテナのIDもしくは名前`でコンテナを削除できる
- `sudo docker rm $(sudo docker ps -aq)`でローカルに存在しているコンテナを一斉削除できる

# コマンドの順番
1. build
2. up
3. db:create
4. down

# ログを確認したいとき
docker-compose ps
でコンテナの名前を確認
docker logs { コンテナの名前 }
でログが見られる

# コマンド一覧
Dockerfileからbuild
docker-compose build

アプリを立ち上げ
docker-compose up

バックグラウンドでサーバーを起動（Terminalの画面を分割する必要がなくなる）
docker-compose up -d

webというのは、docker-compose.ymlにあるservicesのこと
rails db:create
docker-compose run web rails db:create

rails db:migrate
docker-compose run web rails db:migrate

webコンテナの中に入る
docker exec -it nukistagram_web_1 bash

↑のコマンドを打ってから↓のコマンドを打つとconsoleに入れる
[bash]rails c

コンテナの削除
docker rm a403ffe73d31

コンテナを一括削除。docker ps -aで出てくる各イメージをdocker rmの引数にしている
docker rm "$(docker ps -a)"

起動しているコンテナ一覧
docker ps

現状のコンテナの確認(すべて)
docker ps -a

現状のイメージの確認
docker images

イメージの削除
docker rmi 2f37bab81128

イメージを一括削除。docker ps -aで出てくる各イメージをdocker rmの引数にしている
docker rmi "$(docker images)"

rails new
docker-compose run web rails new . --force --database=mysql --skip-bundle

herokuにてconsoleを立ち上げたいとき
heroku run docker-compose run web rails c

# consoleへの入り方

docker-compose run web rails console
でいける。もしくは、

docker psとうつ
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                               NAMES
aae3a56fb972        follop-server_web   "/bin/sh -c 'rm -f /…"   7 minutes ago       Up 7 minutes        0.0.0.0:3000->3000/tcp              follop-server_web_1
1a0039787428        mysql:5.7           "docker-entrypoint.s…"   7 minutes ago       Up 7 minutes        0.0.0.0:3306->3306/tcp, 33060/tcp   follop-server_db_1


`$ docker exec -it (CONTAINER ID/NAMES) bash`

そして、
rails c
でイケる

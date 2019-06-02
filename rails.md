# 新規Railsプロジェクトの作成手順
$ gem install rails
$ rails new projece-app
だと、システムのgemにインストールされてしまう。特定のプロジェクトごとに管理したい。
gemはvendor/bundleに入れてbundle execで呼び出すのが良い。

$ mkdir test-app
$ cd test-app
$ bundle init
Writing new Gemfile to /path/to/project_name/Gemfile

次に生成されたGemfileを編集。
in Gemfile
gem "rails"

bundle installする。
$ bundle install --path vendor/bundle

$ bundle exec rails new . -B -d mysql --skip-turbolinks --skip-test


new .にすることでcurrent directoryに生成できる.

オプション	効果
-d, --database=DATABASE	指定したデータベースに変更する（railsのデフォルトのDBはsqlite3）
--skip-turbolinks	turbolinksをオフにする　
--skip-test	railsのデフォルトのminitestというテストを使わない時に付ける。RSpecなどほかのテストフレームワークを利用したい時に使うと良い
ｰB, --skip-bundle	Railsプロジェクト作成時にbundle installを行わないようにする

そして、.gitignoreを編集
https://www.gitignore.io/api/rails
をコピって来れば良し

$ rails db:create
で忘れずにdatabaseを生成しておく

最後にgit initして、レポジトリを作ってpushまでもっていけば完了

どこかのタイミングで、

$ bundle install --path vendor/bundle --without staging production --jobs=4

と打っておき、bundle installを高速化する。--jobs=4で並列処理。--without staging productionで、ST、本番環境のgemは後回しに。

# gem の実行
$ bundle exec gem hogehoge
直でgem hogehogeとやってしまうとシステムにインストールされたgemを参照してしまうので.
e.g.) $ bundle exec rspec spec


# Gemfile
必須gemを列挙しておく
gem 'haml-rails'

# template テンプレートエンジン haml slim generator やり方
gem 'haml-rails'
がGemfileに入っていることを確認したら、
config/application.rbを開き、
---
    config.generators do |g|
      g.stylesheets :sass
      g.javascripts false
      g.helper false
      g.template_engine :haml
      # g.test_framework :rspec, view_specs: false, helper_specs: false, fixture: true
      # g.fixture_replacement :factory_girl, dir: "spec/support/factories"
    end
---
と書き込む。書き込み位置は、configが書いてあるところと同じ階層。

書き込んで動作確認した段階で一旦コミット

# rails generate/destroy
## controller
コントローラー名は複数形で、頭文字を大文字にする。
- indexアクションを持つUsersコントローラーを作るときは次のように入力する。
$ rails g controller Users(controller名) index(action名)
- destroyしたいとき。
$ rails destroy ontroller Users(controller名) index(action名)

## model
モデル名は単数形で、頭文字を大文字にする。
-  name、emailの2つの項目を持つUserモデルを作るとき。
$ rails g model User name:string email:string

- カラムを追加するとき
行う処理+テーブル名
Userにemailを追加したいとき
$ rails g migration add_email_to_users(or AddEmailToUsers)
---
def change
  add_index :users, :email, unique: true
end
---

# routes.rb
## root
root 'controller#action'で/のpathを指定できる
## resources

# rails console readline
- brew install readlineで、already installedと出た場合
シンボリックが問題っぽい
$ ln -s /usr/local/opt/readline/lib/libreadline.dylib /usr/local/opt/readline/lib/libreadline.7.dylib
で解決

# scrape スクレイピングしたデータをActiveRecordに保存したいとき
rake task タスクを作成して、そこで処理をする。

$ rails g task hogehoge
tasks/hogehogeを開き、
---
namespece :hogehoge do
  task :some_name => :environment do // environmentがないとDBにアクセスできない
  User.create(name: , age: )
  logger = Logger.new('log/pornhub_videos.log') // logも取っておきたい
  logger.info "#{Time.now} -- blah-blah-blah: #{content}"
end
---
で、terminal上で
$ bundle exec rake hogehoge:some_name
で処理が実行できる。

## scrape 画像 もってくる
ex) naver_matome
---
url = 'http://matome.naver.jp/tech'

doc.xpath('//li[@class="mdTopMTMList01Item"]').each do |node|
  # tilte
  p node.css('h3').inner_text

  # 記事のサムネイル画像
  p node.css('img').attribute('src').value

  # 記事のサムネイル画像
  p node.css('a').attribute('href').value
end
---

# image_tag 使い方
- hamlの場合
= image_tag(画像のpath)
もしくは、
= image_tag path
でも可能。rubyはメソッドの()が省略できるため

# image link 画像リンクを作る時
- haml
---
= link_to link_path, target: "_blank" do_
  = image_tag image_path // なぜか_を入れると色がおかしくなる。本当は、doのあとの_はいらない。当たり前だけど。さらに言うと、doはいらない。ブロックパラメータがないので。
---

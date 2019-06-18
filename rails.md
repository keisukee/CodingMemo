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

# rails generate/destroy migration
## controller
コントローラー名は複数形で、頭文字を大文字にする。
- indexアクションを持つUsersコントローラーを作るときは次のように入力する。
$ rails g controller Users(controller名) index(action名)
- destroyしたいとき。
$ rails destroy ontroller Users(controller名) index(action名)

### ネストしたいとき
`rails g controller admin::video`と打てばよい

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
  add_column :users, :email, :string
end
---

- カラムを変更するとき
rails generate migration rename_titre_column_to_books
---
class RenamePiblishedColumnToBooks < ActiveRecord::Migration
  def change
    rename_column :books, :titre, :title
  end
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

# link_to 書き方
= link_to path, "text"

# controller action viewから取得したい
<%= controller.controller_name %>
<%= controller.action_name %>
で取れる

# 各controllerごとでstyle, cssを使い分けたい時
application.html.erbで、
<body class='<%= "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"%>'>
とすると、css側から各controllerごとにstyleを当てられるし、まとめて当てることもできる

# render header footer
<%= render 'layout/header' %>
でいける

# kaminari pagination ページネーション
gem 'kaminari', '~> 0.17.0'

bundle install したのち、目的のcontrollerにて、
```
PER = 8
def index
  @videos = Video.page(params[:video]).per(PER)
end
```
とする

# ブロック構文
以下の二つの構文は同値である
```
Video.create do |video|
  video.title = video_title
  video.url = url + video_path
  video.image_url = video_thumbnail
  video.duration = video_duration
  video.site = "Pornhub"
end

```

```
  Video.create(name: video_title, url: url + video_path, image_url: video_thumbnail, duration: video_duration)
```

# 改行削除 編集
strip: stripは文字列の前後のホワイトスペースをすべて削除。ホワイトスペースとは、改行コード、半角スペース、タブの３つを含んだ総称。文字列の中間にあるホワイトスペースは削除しない
chomp: 文字列の末尾の改行コードのみを削除

# foreign key 外部キー制約
たとえばadd_foreign_key :posts, :usersの場合にはデータベースレベルでposts.user_idにusers.idにある値しか入れられないようにする（それ以外の値を入れようとすればエラーになる）、という仕組み

# 多対多 n:n n対nのモデルを作る
大きくわけて方法は二つ。
1. has_many :through関連付け
2. has_and_belongs_to_many関連付け
この方法の特徴としては、関連付けのために中間モデルを必要としないことになる。もちろん中間テーブルは必要となるが、それだけ。後は各modelに
has_and_belongs_to_many :models
と書いてやればそれだけで完了。

videoモデルとtagモデルが存在していて、多対多の関係を作りたいとする。なおすでにvideoのMVCは作成済み
このとき、まずTag Controllerの作成をし、そこからTagモデルの作成をし、最後に中間テーブルの作成をする。
`rails g controller Tags index show destroy edit new create update`
`rails g model Tag name:string`
`rails g migration create_tags_videos tag:references video:references`
なお、最後のコマンドを打つと、referencesになって外部キー制約が勝手に追加されるが、基本的にそのままで問題ない

これでconsole上にて、video.tag_ids, tag.video_ids,でそれぞれのIDを取得できるとともに、video.tags, tag.videosでお互いのインスタンスが保有しているデータを引っ張ってこれる

# consoleで複数データを一括更新したいとき
update_allを使うべし

# NoSQLとSQLを併用する redis
とりあえず`gem install redis`
で、environments/development.rb以下に
ENV["REDIS"] = "localhost:6379"
と記載。
また、本番環境でAWSなどのサーバーに繋ぐ場合は、environments/production.rb以下に
ENV["REDIS"] = "xxxx.xxxx.chache.amazonaws.com:6379" # Endpoint + Port
などと記述。

で、次に config/initializers/redis.rb に
```
require 'redis'
uri = URI.parse(ENV["REDIS"])
REDIS = Redis.new(host: uri.host, port: uri.port)
```
と記述

で実際に動かしてみる。まず、ターミナル上で
`redis-server`
と打たないと、redisが起動しない。アプリ上でredisを使いたい場合はこれを常時起動しておく必要がある。rails serverと似たようなもの。
つまり、例えばrailsでアプリを作る際はrailsのサーバーとredisのサーバーの二つを同時に動かす必要がある。

# railsでPV数を取得してランキング機能を作る
一個上の # NoSQLとSQLを併用する redis を参照し、redisを導入。
そこから、PVを取得したcontrollerのaction（大抵はshowアクションだろうか）にて、例えば、
REDIS.incr "videos/daily/#{Date.today.to_s}/#{@video.id}"
などとやればそのcontrollerのactionが呼ばれるたびに値がインクリメントされる。
これをview側で出力するには、
(show.html.hamlにて)

= Redis.current.get("videos/daily/#{Date.today.to_s}/#{@video.id}")

などとしてやればよい

# resources意外のactionを追加したいとき
例えば、videosコントローラーにrankingアクションを追加し、viewとして、videos/rankingというものを作りたいとする。このときは、
rootingで、
get 'videos/ranking', to: 'videos#ranking'
としてあとはcontrollerにactionを追加してやればOK

# error エラー
couldn't find (controller名) with 'id'=(action名)
というエラーが出たときの対策
1. rootingで競合している箇所の順番を変える。例えば、resources以外のrootingをそのcontrollerのresourcesより上に持ってくるなど

# validation
validates :name, presence: true
でいける

# if文
```
if 条件イ
  条件イを満たす場合の処理
elsif 条件ロ
  条件ロを満たす場合の処理
elsif 条件ハ
  条件ハを満たす場合の処理
else
  条件イ、ロ、ハを全て満たさない場合の処理
end
```

# form_forの書き方
```
<%= form_for [:admins, @video] do |f| %>
  <p>
  <%= f.label(:title, "タイトル") %>
  <%= f.text_field :title %>
  </p>
  <p>
    <%= f.label :url, "URL" %>
    <%= f.text_field :url %>
  </p>
  <p>
  <%= f.label :duration, "duration" %>
  <%= f.text_field :duration %>
  </p>
  <%= f.submit "変更" %>
<% end %>

```
controllerがネストされているとき、[:admins, @video]のように書くことでうまくアクションを指定できる。また、method: "post"とか、action: updateとか書かなくてもOK

## edit update controllerの書き方
```
def edit
  @video = Video.find(params[:id])
end

def update
  @video = Video.find(params[:id])
  @video.update(video_params)
  redirect_to admins_videos_path
end

private
  def video_params
    params.require(:video).permit(:title, :url, :duration)
  end
```

# destroy
```
def destroy
  @video = Video.find(params[:id])
  @video.destroy
  redirect_to root_path
end

----

%td= link_to '削除する', admins_video_path(video), method: :delete
```

# 複数レコードを一括更新
Article.update([1, 2], [{ title: 'title1', body: 'body1' }, { title: 'title2', body: 'body2' }])

# 部分テンプレート partial
<%= render :partial => "article", :locals => { title: @article.title } %>

# before_action
before_action :require_login, only: [:new, :create]

# strong parameters ストロングパラメータ permit
def video_params
  params.require(:video).permit(:title, :url, :duration)
end

# rspec テスト セットアップ
## installするgem
```
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'capybara'
end
```

## コマンド
`bundle install`
`bundle exec rails generate rspec:install`
`bundle exec rspec spec/controllers/`などでテストを実行

## 各種設定
```config/application.rb
config.generators do |g|
  g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        controller_specs: false,
        routing_specs: false
end

```
rails generate modelなどのコマンドを打つと勝手にrspecファイルも同時に生成されるのだが、ここの設定でfalseにしておくと作成されなくなる。ここは各自で設定する。↑のように書くとrequest_spec, model_specファイル以外は生成されない。
こういう設定もできる（実際に使ったコードはこっち）
```
config.generators do |g|
  g.test_framework :rspec,
                        fixtures: true,
                        view_specs: false,
                        helper_specs: false,
                        routing_specs: false,
                        controller_specs: true,
                        request_specs: false
   g.fixture_replacement :factory_bot, dir: "spec/factories"
end
```

続いてFactoryBotの設定

```spec/rails_helper.rb
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```
上記のように書くと、FactoryBotでインスタンスを生成するときに名前空間を省略できる　
```
# 通常FactoryBotをつけないと、メソッドを呼べない
user = FactoryBot.create(:user)

# 上の設定を追加することで、FactoryBotの記述が省略できる。
user = create(:user)
```

## FactoryBotの書き方
```/spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:email) { |n| "TEST#{n}@example.com"}
  end
end
```

# テスト環境のコンソールを開く
rails c -e test --sandbox

## FactoryBotで設定したインスタンスを生成したい
```/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s}@test.com"}
    password { 'password' }
  end
end
```
consoleにて、
`FactoryBot.create(:user)`
と打つといける

# FactoryBot associations has_many has_and_belongs_to_many
video has_and_belongs_to_many tag
tag has_and_belongs_to_many video
```
FactoryBot.define do
  factory :video do
    sequence(:title) { |n| "title-test-#{n.to_s}@test.com"}
    sequence(:url) { |n| "https://hogehoge#{n.to_s}.com"}
    sequence(:image_url) { |n| "https://hogehoge-image-url-#{n.to_s}.com"}
    site { 'test-site' }
    duration { '120:00' }

    factory :video_with_tags do
      transient do
        tags_count { 1 }
      end

      after(:create) do |video, evaluator|
        create_list(:tag, evaluator.tags_count, videos: [video])
      end
    end
  end

  factory :tag do
    name { 'test-tag' }
  end
end
```

# RSpec feature spec
サンプルコード
```
require 'rails_helper'

feature '管理画面へのアクセス' do
  let!(:normal_user) { create(:user_with_role_normal) }
  let!(:admin_user) { create(:user_with_role_admin) }

  scenario 'userログインしていない場合アクセスできない' do
    visit admins_path
    expect(current_path).to eq root_path
  end

  scenario 'userログインしていても、roleがadminでない場合アクセスできない' do
    visit new_user_session_path

    fill_in 'Email', with: normal_user.email
    fill_in 'Password', with: normal_user.password
    click_on 'Log in'

    visit admins_path
    expect(current_path).to eq root_path
  end

  scenario 'userログインしておりかつroleがadminの場合アクセスできる' do
    visit new_user_session_path

    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password
    click_on 'Log in'

    visit admins_path
    expect(current_path).to eq admins_path
  end
end
```

# describe context it feature scenario等の違い
capybaraを使ってfeatureテストを行う場合
- describe ... type: :featureの代わりにfeature
- beforeの代わりに、background
- itの代わりに、scenario
- letの代わりにgiven

featureスペック以外（modelスペックなど）の場合は、
```
describe '#hogehoge?' do #インスタンスメソッド
  let(:start_at){Time.zone.local(2016, 8, 1, 9, 00, 00)} # 変数定義
  let(:end_at){Time.zone.local(2016, 8, 31, 12, 30, 00)} # 変数定義
  subject do # オブジェクト
    event = Event.new
    event.start = start_at
    event.end = end_at

    # インスタンスメソッドの戻り値がsubjectにセットされる
    event.hogehoge?(Time.zone.local(2016, 8, 4, 00, 00, 00))
  end
  context 'start_atがnilの場合' do
    let(:start_at) { nil }
    it {expect(subject).to be false} # subjectがfalseだったらOK
  end
end
```
こういう感じで書く。

つまり、
- feature spec
  - feature
    - context
      - scenario
      - background
      - given
- model specなど
  - describe
    - context
      - it
      - before
      - let

って感じ

# 新規Railsプロジェクトの作成手順
```
$ gem install rails
$ rails new projece-app
```
だと、システムのgemにインストールされてしまう。特定のプロジェクトごとに管理したい。gemはvendor/bundleに入れてbundle execで呼び出すのが良い。

```
$ mkdir test-app
$ cd test-app
$ bundle init
```

次に生成されたGemfileを編集。
```
in Gemfile

gem "rails"
```

bundle install
```
$ bundle install --path vendor/bundle
$ bundle exec rails new . -B -d mysql --skip-turbolinks --skip-test
```

new .にすることでcurrent directoryに生成できる.

オプション 効果
- -d, --database=DATABASE	指定したデータベースに変更する（railsのデフォルトのDBはsqlite3）
- --skip-turbolinks	turbolinksをオフにする
- --skip-test	railsのデフォルトのminitestというテストを使わない時に付ける。RSpecなどほかのテストフレームワークを利用したい時に使うと良い
- ｰB, --skip-bundle	Railsプロジェクト作成時にbundle installを行わないようにする

そして、.gitignoreを編集
[https://www.gitignore.io/api/rails]
をコピって来れば良し

`$ rails db:create`
で忘れずにdatabaseを生成しておく

最後にgit initして、レポジトリを作ってpushまでもっていけば完了

どこかのタイミングで、

`$ bundle install --path vendor/bundle --without staging production --jobs=4`

と打っておき、bundle installを高速化する。--jobs=4で並列処理。--without staging productionで、ST、本番環境のgemは後回しに。

## 既存のhtmlファイルやerbをhaml, slimに一括で変更する
`gem 'html2slim'`をインストール後、

`for i in app/views/**/*.erb; do erb2slim $i ${i%erb}slim && rm $i; done`

# gem の実行
`$ bundle exec gem hogehoge`

直でgem hogehogeとやってしまうとシステムにインストールされたgemを参照してしまうので.
e.g.) $ bundle exec rspec spec

# Gemfile
必須gemを列挙しておく
gem 'haml-rails'

# template テンプレートエンジン haml slim generator やり方
gem 'haml-rails'
がGemfileに入っていることを確認したら、
config/application.rbを開き、
```
    config.generators do |g|
      g.stylesheets :sass
      g.javascripts false
      g.helper false
      g.template_engine :haml
      # g.test_framework :rspec, view_specs: false, helper_specs: false, fixture: true
      # g.fixture_replacement :factory_girl, dir: "spec/support/factories"
    end
```
と書き込む。書き込み位置は、configが書いてあるところと同じ階層。

書き込んで動作確認した段階で一旦コミット

# rails generate/destroy migration
## controller
コントローラー名は複数形で、頭文字を大文字にする。
```
indexアクションを持つUsersコントローラーを作るとき
$ rails generate controller Users(controller名) index(action名)

destroyしたいとき
$ rails destroy ontroller Users(controller名) index(action名)
```

### ネストしたいとき
`rails generate controller admin::video`と打てばよい

## model
モデル名は単数形で、頭文字を大文字にする。
-  name、emailの2つの項目を持つUserモデルを作るとき。
$ rails generate model User name:string email:string

- カラムを追加するとき
行う処理+テーブル名
Userにemailを追加したいとき
$ rails generate migration add_email_to_users(or AddEmailToUsers)
```
def change
  add_column :users, :email, :string
  add_column :accounts, :ssl_enabled, :boolean, default: true

  remove_column :titles, :place, :string
end
```

- カラムを変更するとき
rails generate migration rename_titre_column_to_books
```
class RenamePiblishedColumnToBooks < ActiveRecord::Migration
  def change
    rename_column :books, :titre, :title
  end
end
```

- テーブル名を変更するとき
`rails generate migration change_[old_table_name]_to_[new_table_name]`

def change
  rename_table :[old_table_name], :[new_table_name]
end

- カラムの型を変更したい時
`rails generate migration ChangeNumberOfBankAccountInfo`

カラムの型を変更するときは、migrationの前後の変化を記述する。でないと型が何から何に変わったかわからず、rollbackできなくなるため
```
class ChangeDatatypeNumberAndBranchNameOfBankAccountInfo < ActiveRecord::Migration[5.2]
  def up
    change_column :bank_account_infos, :number, :string
  end

  def down
    change_column :bank_account_infos, :number, :integer
  end
end
```

# polymorphic関連付けを削除したい場合
```migration
  def up
    change_table :books do |t|
      t.remove_references :readable, polymorphic: true
    end
  end

  def down
    change_table :books do |t|
      t.add_references :readable, polymorphic: true
    end
  end
```
# routes.rb

## namespace scope module 違いまとめ
```
namespace :admin do
  resources :users
end

# rake routes
        Prefix Verb   URI Pattern                     Controller#Action
   admin_users GET    /admin/users(.:format)          admin/users#index
               POST   /admin/users(.:format)          admin/users#create
new_admin_user GET    /admin/users/new(.:format)      admin/users#new
dit_admin_user GET    /admin/users/:id/edit(.:format) admin/users#edit
    admin_user GET    /admin/users/:id(.:format)      admin/users#show
               PATCH  /admin/users/:id(.:format)      admin/users#update
               PUT    /admin/users/:id(.:format)      admin/users#update
               DELETE /admin/users/:id(.:format)      admin/users#destroy

scope module: :admin do
  resources :users
end

# rake routes
   Prefix Verb   URI Pattern               Controller#Action
    users GET    /users(.:format)          admin/users#index
          POST   /users(.:format)          admin/users#create
 new_user GET    /users/new(.:format)      admin/users#new
edit_user GET    /users/:id/edit(.:format) admin/users#edit
     user GET    /users/:id(.:format)      admin/users#show
          PATCH  /users/:id(.:format)      admin/users#update
          PUT    /users/:id(.:format)      admin/users#update
          DELETE /users/:id(.:format)      admin/users#destroy

scope '/admin' do
  resources :users
end

# rake routes
   Prefix Verb   URI Pattern                     Controller#Action
    users GET    /admin/users(.:format)          users#index
          POST   /admin/users(.:format)          users#create
 new_user GET    /admin/users/new(.:format)      users#new
edit_user GET    /admin/users/:id/edit(.:format) users#edit
     user GET    /admin/users/:id(.:format)      users#show
          PATCH  /admin/users/:id(.:format)      users#update
          PUT    /admin/users/:id(.:format)      users#update
          DELETE /admin/users/:id(.:format)      users#destroy
```

## root
root 'controller#action'で/のpathを指定できる
## resources
```
  root to: 'clients/home#index'
  resources :posts, only: [:index, :show, :destroy]
```
## namespace
```
namespace :v3 do
    get "/test/read",:to=>"test#read"
end
```
と書くと

```
GET  /v3/test/read(.:format)    v3/test#read
```

## scope
```
scope :v3 do
  get "/test/read",:to=>"test#read"
end
```
と書くと
```
GET  /v3/test/read(.:format)    test#read
```
## resources意外のactionを追加したいとき
例えば、videosコントローラーにrankingアクションを追加し、viewとして、videos/rankingというものを作りたいとする。このときは、
rootingで、
get 'videos/ranking', to: 'videos#ranking'
としてあとはcontrollerにactionを追加してやればOK

## member&collection
memberは:idを伴うpathを追加する時
```
resources :photos do
  member do
    get :preview
  end
end
-> /photos/:id/preview

追加したいメンバルーティングが1つならonオプションを使うと1行でいける
resouces :photos do
  get :preview, on: :member
end

photos/:id/preview
```

collectionは:idを伴わないpathを追加する時
```
resources :photos do
  collection do
    get :search
  end
end
-> /photos/search
```
# こちらもonオプションで1行に
resouces :photos do
  get :search, on: :collection
end

-> photos/search
```

# rails console readline
- brew install readlineで、already installedと出た場合
シンボリックが問題っぽい
$ ln -s /usr/local/opt/readline/lib/libreadline.dylib /usr/local/opt/readline/lib/libreadline.7.dylib
で解決

# scrape スクレイピングしたデータをActiveRecordに保存したいとき
rake task タスクを作成して、そこで処理をする。

$ rails generate task hogehoge
tasks/hogehogeを開き、
```
namespece :hogehoge do
  task :some_name => :environment do // environmentがないとDBにアクセスできない
  User.create(name: , age: )
  logger = Logger.new('log/pornhub_videos.log') // logも取っておきたい
  logger.info "#{Time.now} -- blah-blah-blah: #{content}"
end
```
で、terminal上で
$ bundle exec rake hogehoge:some_name
で処理が実行できる。

## scrape 画像 もってくる
ex) naver_matome
```
url = 'http://matome.naver.jp/tech'

doc.xpath('//li[@class="mdTopMTMList01Item"]').each do |node|
  # tilte
  p node.css('h3').inner_text

  # 記事のサムネイル画像
  p node.css('img').attribute('src').value

  # 記事のサムネイル画像
  p node.css('a').attribute('href').value
end
```
```
# image_tag 使い方
- hamlの場合
= image_tag(画像のpath)
もしくは、
= image_tag path
でも可能。rubyはメソッドの()が省略できるため

# image link 画像リンクを作る時
- haml
```
= link_to link_path, target: "_blank" do_
  = image_tag image_path // なぜか_を入れると色がおかしくなる。本当は、doのあとの_はいらない。当たり前だけど。さらに言うと、doはいらない。ブロックパラメータがないので。
```

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

# rails generate系のコマンド
## Model/Migration
### モデル作成
`rails generate model User uuid:string:unique name:string`

### テーブル名変更 リネーム
```
$ rails g migration RenameIssueToTask

class RenameIssueToTask < ActiveRecord::Migration
  def change
    rename_table :issues, :tasks
  end
end
```

## Controller


# 多対多 n:n n対nのモデルを作る
大きくわけて方法は二つ。
1. has_many :through関連付け
2. has_and_belongs_to_many関連付け
## has_many :through
```
class User < ApplicationRecord
  has_many :reviews
  has_many :books, through: :reviews
end

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
end

class Book < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
end
```
- 新しくモデルを作成する場合
```
def change
  create_table :users do |t|
    t.string :name
    t.string  :label
    t.text    :value
    t.string  :type
    t.integer :position
    t.timestamps
  end

  create_table :books do |t|
    t.string :name
    t.timestamps
  end

  create_table :books do |t|
    t.belongs_to :user
    t.belongs_to :book
    t.timestamps
  end
end
```
- 既存のモデルに追加する場合
```
def change
  add_reference :reviews, :book, foreign_key: true
  add_reference :reviews, :user, foreign_key: true
end
```
## has_and_belongs_to_many関連付け
この方法の特徴としては、関連付けのために中間モデルを必要としないことになる。もちろん中間テーブルは必要となるが、それだけ。後は各modelに
has_and_belongs_to_many :models
と書いてやればそれだけで完了。

videoモデルとtagモデルが存在していて、多対多の関係を作りたいとする。なおすでにvideoのMVCは作成済み
このとき、まずTag Controllerの作成をし、そこからTagモデルの作成をし、最後に中間テーブルの作成をする。
`rails generate controller Tags index show destroy edit new create update`
`rails generate model Tag name:string`
`rails generate migration create_tags_videos tag:references video:references`
なお、最後のコマンドを打つと、referencesになって外部キー制約が勝手に追加されるが、基本的にそのままで問題ない

これでconsole上にて、video.tag_ids, tag.video_ids,でそれぞれのIDを取得できるとともに、video.tags, tag.videosでお互いのインスタンスが保有しているデータを引っ張ってこれる

# 1対n 1:n has_many & belongs_to
`rails generate model Author name:string`
`rails generate model Book title:string pages:integer`
`rails db:migrate`
後に、
```

class Author < ApplicationRecord
  has_many :books, dependent: :destroy
end

class Book < ApplicationRecord
  belongs_to :author
end
```
そして、外部キーをカラムとして追加する
`rails generate migration add_author_id_to_books`
```
class AddAuthorIdToBooks < ActiveRecord::Migration[6.0]
  def change
    # 基本形: user_idという名前で users.id への外部キー制約をはる
    add_reference :books, :author, foreign_key: true

    # 応用形: user_id以外の名前(assignee_id)という名前で users.id への外部キー制約をはる
    # add_reference :applicants, :assignee, foreign_key: { to_table: :users }
  end
end
```
# 1対1 1:1 has_one 他方のモデルと
UserモデルとWalletモデルが作成済み
```model
class User < ApplicationRecord
  has_one :wallet, dependent: :destroy
end

class Wallet < ApplicationRecord
  belongs_to :user
end
```
外部キーを作成
`rails generate migration add_user_id_to_wallet`
```
class AddUserIdToWallet < ActiveRecord::Migration[6.0]
  def change
    add_reference :wallets, :user, foreign_key: true // has_one_and_belong_toだが、walletはテーブルの名前なので、walletsとする
  end
end
```
`user.wallet`
`wallet.user`
で取得ができる。また、`user.destroy`でwalletは消えるが、`wallet.destroy`としても、`user`は消えない

# has_one :through association 1:1 & 1:1
```
class Supplier < ApplicationRecord
  has_one :account
  has_one :account_history, through: :account
end

class Account < ApplicationRecord
  belongs_to :supplier
  has_one :account_history
end

class AccountHistory < ApplicationRecord
  belongs_to :account
end
```
Supplier -> Account -> AccountHistory
Account -> Supplier
AccountHistory -> Account
Supplier -> AccountHistory
が成り立つ
```
class CreateAccountHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.timestamps
    end

    create_table :accounts do |t|
      t.belongs_to :supplier
      t.string :account_number
      t.timestamps
    end

    create_table :account_histories do |t|
      t.belongs_to :account
      t.integer :credit_rating
      t.timestamps
    end
  end
end
```
# 1対1 1:1 has_one_through 同じモデル内で

# n対n n:n has_many & has_many 違うモデルで
## has_and_belongs_to_many * 2
`rails generate model assemblies_parts assembly:references part:references`
```
class CreateAssembliesParts < ActiveRecord::Migration[6.0]
  def change
    create_table :assemblies_parts, id: false do |t|
      t.references :assembly, index: true, null: false
      t.references :part, index: true, null: false
    end
  end
end
```

```model
class Assembly < ApplicationRecord
  has_and_belongs_to_many :parts
end

class Part < ApplicationRecord
  has_and_belongs_to_many :assemblies
end
```

これで、
```
assembly = Assembly.new(name: "assembly1")
part = Part.new(name: "part1")
assembly.parts << part

assembly.parts -> partsが出てくる
part.assemblies -> assembliesが出てくる
```

##

# n対n n:n has_many & has_many 同じモデル内で
# throughを使いこなす

## alias
```
class Book
  has_many :users, through: :reviews
  has_many :reviewd_users, through: :reviews, foreign_key: "user_id", class_name: "User"
end
```
# polymorphic 多態性を使うタイミング
複数のbelongs_toが存在するとき

テーブルを作成するタイミングでpolymorphicにする場合

```
class CreateReadBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :read_books do |t|
      t.string :title
      t.integer :length
      t.integer :pages

      t.references :readable, polymorphic: true
      # referencesの代わりに、id, type, indexを作ることでも作成可能
      # t.bigint  :readable_id
      # t.string  :readable_type

      t.timestamps
    end
    # add_index :pictures, [:readable_type, :readable_id]
  end
end
```


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


# error エラー
couldn't find (controller名) with 'id'=(action名)
というエラーが出たときの対策
1. rootingで競合している箇所の順番を変える。例えば、resources以外のrootingをそのcontrollerのresourcesより上に持ってくるなど

# validation
validates :name, presence: true
validates :email, uniqueness: true

## 複数のvalidationを一行でかける
validates :name, :uniqueness => true, :presence => true


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
! form_for, form_tag はdepracatedになるので使わないように
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

# form_with

```
= form_with url: run_admins_scrapes_path do |form|
    %li
      index
      = form.select :id, @scrapes.map{|t| [t.tag_name, t.id]}
    %li
      Pornhub
      = form.radio_button('site', 'Pornhub')
    %li
      Xvideos
      = form.radio_button('site', 'Xvideos')
    %li
      Tube8
      = form.radio_button('site', 'Tube8')
    %li
      Youporn
      = form.radio_button('site', 'Youporn')
    %li
      url
      = form.label 'url'
      = form.text_field :url
    %li
      tag_name
      = form.label 'tag_name'
      = form.text_field :tag_name
    %li
      = form.submit 'スクレイピング'

```
= form_with url: clients_shop_path(shop) do |form|
  li
    p 店舗名
    = form.text_field :name, placeholder: '入力してください'
  li
    p 電話番号
    = form.text_field :phone_number, placeholder: '入力してください'
  li
    p 住所
    = form.text_field :zip_code, placeholder: '郵便番号'
    span <br>
    = form.text_field :address, placeholder: '東京都渋谷区〇〇丁目〇〇'
```
```
## 年月などを入力させるselectボックス
```
f.select(プロパティ名, タグの情報 [, オプション])

# @categories = Category.all
<%= f.select :name, @categories.map{|t| [t.name, t.id]} %>
```

# edit update controllerの書き方
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

```-

%td= link_to '削除する', admins_video_path(video), method: :delete
```

# 複数レコードを一括更新
Article.update([1, 2], [{ title: 'title1', body: 'body1' }, { title: 'title2', body: 'body2' }])

# 部分テンプレート partial
```
<%= render :partial => "article", :locals => { title: @article.title } %>

= render '/layouts/aside_bar', shop: @shop
```

# before_action
```
before_action :require_login, only: [:new, :create]
```

# callbacks
```
before_validation
after_validation
before_save
around_save
before_create
around_create
after_create
after_save
after_commit/after_rollback

- Updating a object
before_validation
after_validation
before_save
around_save
before_update
around_update
after_update
after_save
after_commit/after_rollback

- Destroying a object
before_destroy
around_destroy
after_destroy
after_commit/after_rollback
```

## 使用例
```
  before_save :normalize_card_number, if: :paid_with_card?

  before_create do
    self.name = login.capitalize if name.blank?
  end
```

# strong parameters ストロングパラメータ permit
```
def video_params
  params.require(:video).permit(:title, :url, :duration)
end

def user_params
 params.require(:user).permit(:name, :email, :password)
end
```

# set_resource
```
private

def set_book
  @book = Book.find(params[:id])
end
```

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



# flash message

## flash[]
次のリクエストまで。リダイレクトを伴うとき
```controller.rb
flash[:success] = '写真を投稿しました'
flash[:danger] = '写真の投稿に失敗しました'
flash[:notice] = 'お知らせ'
flash[:aiueo] = '文字列を入力'
```
## flash.now[]

現在のリクエストまで。つまり、エラーメッセージなどを出力して、現在の画面からまだ遷移させたくないときに使う
```
flash.now[:alert]
```
 # factory_bot FactoryBot rails consoleで実行したいとき
 rails console -e testでtest環境のDBをいじれる
 で、`FactoryBot.create(:hogehoge)`
 でいける

 # RSpec サンプル
 ```
 require 'rails_helper'
RSpec.describe Api::V1::NotificationsController, type: :request do

  describe '通知API', autodoc: true do
      let!(:path) { '/api/v1/notifications' }
      let!(:session_path) { '/api/v1/auth/sign_in' }
      let!(:current_user) { create(:user) }
      let!(:client) { create(:client) }
      let!(:shop) { create(:shop, client: client) }
      let!(:auth) { create(:auth, user: current_user)}

      let!(:params) {
        {
          name: current_user.name,
          email: current_user.email,
          password: current_user.password
        }
      }

    describe 'GET /v1/notifications' do

      context '正常系(一般)' do

        before do
          login
          # authがupdateされると通知が作られるが、rejectされるとauthがdestroyされるので、先にapprovedにしている
          auth.update(status: 1) # approved
          auth.update(status: 2) # rejected

          post = Post.create(
            url: "https://instagram.com" + "hogehoge",
            provider: "instagram",
            followers_count: 500,
            status: "unapproved",
            uid: "oigeji29",
            user_id: current_user.id,
            shop_id: shop.id
          )
          # postのstatusが1か2にupdateされると通知が作られるが、rejectされるとauthがdestroyされるので、先にapprovedにしている
          post.update(status: 1) # approved
          post.update(status: 2) # rejected

          auth_params = get_auth_params_from_login_response_headers(response)
          get path, headers: auth_params
        end

        it '新規Shopがcreateされたときに通知がが返ってくる' do
          notification = current_user.notifications.find_by(message: "新規店舗が追加されました")
          expect(notification).to be_present
        end

        it 'Userのauthが承認されたときに通知が返ってくる' do
          notification = current_user.notifications.find_by(message: "アカウントが承認されました")
          expect(notification).to be_present
        end

        it 'Userのauthが承認されなかったときに通知が返ってくる' do
          notification = current_user.notifications.find_by(message: "アカウントが承認されませんでした")
          expect(notification).to be_present
        end

        it 'Userのpostが承認されたときに通知が返ってくる' do
          notification = current_user.notifications.find_by(message: "投稿が承認されウォレットに入金されました")
          expect(notification).to be_present
        end

        it 'Userのpostが承認されなかったときに通知が返ってくる' do
          notification = current_user.notifications.find_by(message: "投稿が承認されませんでした")
          expect(notification).to be_present
        end

        it 'ステータスコード 200 Success が返ってくる' do
          expect(response.status).to eq(200)
        end

      end

    end

    describe 'GET /v1/notifications/:id' do

      before do
        login
        auth_params = get_auth_params_from_login_response_headers(response)
        id = current_user.notifications.first.id
        get "/api/v1/notifications/#{id}", headers: auth_params
      end

      it '確認した通知のstatusがread(既読)になっている' do
        notification = current_user.notifications.first
        expect(notification).to be_present
        expect(notification.status).to eq('read')
      end

    end

    def login
      post session_path, params:  { "email": "#{current_user.email}", "password": "password" }.to_json, headers: { 'Content-Type' => 'application/json' }
    end

    def get_auth_params_from_login_response_headers(response)
      client = response.headers['client']
      token = response.headers['access-token']
      expiry = response.headers['expiry']
      token_type = response.headers['token-type']
      uid = response.headers['uid']

      auth_params = {
          'Content-Type' => 'application/json',
          'access-token' => token,
          'client' => client,
          'uid' => uid,
          'expiry' => expiry,
          'token_type' => token_type
      }
      auth_params
    end

  end
end
```

# dockerでDB接続
host: 127.0.0.1
password: password(docker-compose.ymlで設定したdbのパスワード)
user: root
データベース名: (nil)

# library module をrailsプロジェクト内で使うためには
```config/application.rb
  config.autoload_paths += %W(#{config.root}/lib) # add this line
```

```customer.rb
class Customer < ActiveRecord::Base
  include Foo
end
```

```lib/foo.rb
module Foo
  def hello
    "hello"
  end
end
```
これで、model内で、読み込んだmoduleがインスタンスメソッドとして使える

## module内でクラスメソッドを定義したい場合
```lib/some_module.rb
module SomeModule
  def self.hogehoge
  end
end
```

moduleからメソッドを呼び出すときには
```model/some_model.rb
class SomeModel
  def fuga
    SomeModule.hogehoge
  end
end
```
# 時間を扱いたい時
railsではTimeWithZoneクラスを用いる
```
[32] pry(main)> t = Time.zone.now
=> Sun, 15 Sep 2019 14:02:14 UTC +00:00
[33] pry(main)> t.class
=> ActiveSupport::TimeWithZone

[18] pry(main)> t.beginning_of_year
=> Tue, 01 Jan 2019 00:00:00 UTC +00:00

[19] pry(main)> t.beginning_of_month
=> Sun, 01 Sep 2019 00:00:00 UTC +00:00

[20] pry(main)> t.end_of_month
=> Mon, 30 Sep 2019 23:59:59 UTC +00:00

[21] pry(main)> t.end_of_year
=> Tue, 31 Dec 2019 23:59:59 UTC +00:00

[29] pry(main)> 1.month.before
=> Thu, 15 Aug 2019 14:03:23 UTC +00:00

[31] pry(main)> 1.month.after - 1.month
=> Sun, 15 Sep 2019 14:03:41 UTC +00:00
```

# where ? 条件で絞り込む 不等式
```
User.where(["created_at < ? and created_at > ?", 1.day.after, 1.day.ago])
User.where(["? < created_at and created_at < ?", 1.day.ago, 1.day.after])
```

```
Comment.where.not(receiver_id: nil).where.not(value: nil)
```

# child のレコード数でsort, order
```
book has_many reading_histories
reading_history belongs_to book

Book.select('books.*', 'count(reading_histories.id) AS users').left_joins(:reading_histories).group('books.id').order('users desc')
```
```
Book.joins(:reading_histories).where(reading_histories: {status: "read"})
```

```Book.joins(:reading_histories).where(reading_histories: {status: "wish"}).select('books.*', 'count(reading_histories.id) AS users').group('books.id').order('users desc')

```

# herokuデプロイ
```
# Herokuアプリを作成する
$ heroku create <アプリ名>

Creating app... done, ⬢ xxxxx-xxxxx-xxxxx
https://xxxxx-xxxxx-xxxxx.herokuapp.com/ | https://git.heroku.com/xxxxx-xxxxx-xxxxx.git

$ git remote add heroku https://git.heroku.com/xxxxx-xxxxx-xxxxx.git

# remoteにherokuが追加されていることを確認する
$ git remote

$ git push heroku master

# その他コマンド

# 環境変数一覧
$ heroku config

# 環境変数名を指定して参照
$ heroku config:get ENV_NAME

# 環境変数を追加
$ heroku config:set ENV_NAME="value"

# 環境変数を削除
$ heroku config:unset ENV_VAR_NAME
```

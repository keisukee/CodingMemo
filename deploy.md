ssh -i follop-app-server-rsa ec2-user@52.68.78.253

# 既存の秘密鍵の公開鍵を生成する
ssh-keygen -y -f pk-APKAJJFZZZEEDLPOOKOQ.pem > pk-APKAJJFZZZEEDLPOOKOQ.pub

# ssh-agentに秘密鍵を追加
ssh-add hogehoge.pem

# ファイルの権限
- read 4
- write 2
- excute 1

-/---/---/---

最初の-はディレクトリorファイル
---は、rweを表す
1個目の---は管理者
2個目の---はグループ
3個目の---は他人

r+w+eの数で、権限を変えられる
例えば、
chmod 400 hogehoge.pem なら、
hogehoge.pem -r--------
つまり、ユーザーのみreadができるということ。


chmod 777 hogehoge.pemなら、
誰でも読み書き実行できる

# config
Host github
  Hostname github.com
  User git
  IdentityFile ~/.ssh/follop-app-server-rsa

Host follop-server
Hostname 18.182.232.228
User kenzo
IdentityFile ~/.ssh/follop-app-server-rsa
Port 22

Host follop-server-1c
Hostname 54.65.78.163
User kenzo
IdentityFile ~/.ssh/follop-app-server-rsa
Port 22

Host follop-staging-server
Hostname 52.69.231.137
User kenzo
IdentityFile ~/.ssh/follop-app-server-rsa
Port 22

これで、
```
ssh follop-staging-server
```
などと叩くことでec2に入れる

# awsのauthorized_keys
ssh-rsa 〇〇（公開鍵の中身）hogehoge(公開鍵の名前)
```
[ec2-user@ip-10-0-3-210 .ssh]$ cat authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcCoILzljqXYkU+wsxda8iBGt6lwbpRPoVJvZrhOWiHgmIpUHY+TcrNpyxUyIyzhyATkM5+uqg8EascyfnUPKcRwTXMsq7WlmtPPg769i8y0hNVmuRjsCO/XiNdlx1l6bSw2WtjG9tpcyro12+LE8+5vmWcy6FL6anrsrNPj9JHcYWscagWtwDHyjH/HFOm+GO0hUlXg/Vo8TPcDk3UCvQ8jmelxuLXLjAD1uHm0pFDBHyiMOQTpVe0FAE1Kp2YASwqCh8FYS+/9e0NwbvqDNvUT9oRC9X1BEam5hjbH+fxvxdCCeAY42XUVbVRaofqNKgM4PzOxol17STwI0+YZiZ follop-app-server
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDC8yOK/j/9CxMYfYYhP9mtFAT7MEGiZrhg4TNvz62Nhqrjz8slV+mkrFZ5FcI2MQmDziOpIHWaw7VnhuB4ar9kC28Vq24Qu40mbs66Zd6/QqFgq43jj2O9YC6OgpweZ3GvAjOCpKzFb2IO9rRqTiVOuSqOaUZFc3tFAwk1PP328Mf4N8Ee4QSEoo4VDdY6otVYpsC+gDtqAag7MpVvPGUKcxj9BDnQiYW9QgLryzAMChQ8KTDPQo78rOAkfR8dswSJfV0rFrCUjfuUaWNaj6Kz1lH9cWxaztAsREbE3rORJLNsxV51u+W7eml2NcxRIYpPFkzXGUgZs/3rDs8TYgst follop-app-server-rsa
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCSlH7xGIC6Uwk6Rk1bOwcAoiGUvnfCz3doCZxDWmZ/2ytypqA1qCsRYDFzeq7yZEIJca3BQFuGgW9ul+d1IXI/N6zbZvyZL/wRghxvgSnh+8VXI5/47OXKgoKSkOaKQViSVWkAYZv2ZwFU23xZX2ClxjB8ilLtf82WWxkbABjMFsSW0iVAsZCKerQTmILXKdxqB+zRk2xDy7FRenvxcfSW5HIguFSsEB0i8+J4aC4nqWHD9FTHwHJvpvOnknCGt0yJtnb5WkCU2XtyTISnXC8FGrS0hKaYX7j3HzMuh9NioSc0PXg7XyNr87ugJQGpbfPhbP1MyT+WXQc8YZ4ZdoxH follop-staging-server-rsa
```

# EC2インスタンスに入る

```
ssh -i follop-app-server-rsa ec2-user@ec2-13-231-178-149.ap-northeast-1.compute.amazonaws.com
```
follop-app-server-rsaはEC2インスタンスを生成するときに決めた秘密鍵（もしくは、EC2インスタンスの.ssh/authorized_keysに設定された鍵）
ec2-userはログインするユーザーの名前。@以下はIPアドレスorパブリックIP

# AWSの各サービス
- EC2
  - AMI
  - EBS(elastic block store)
  - Elastic IP
  - セキュリティグループ
- VPS

# git ssh
~/.ssh/configに
```
Host github
 Hostname github.com
 User git
 IdentityFile ~/.ssh/follop_git_rsa
```
と記述し
```
ssh -T github
```
とやるのは、

```
ssh -T git@github.com
```
とやることと等価。githubに登録したSSH keyがid_rsa.pubなど以外だった場合、`ssh -T git@github.com
`と叩いても、秘密鍵を参照してくれない。そのときに出てくるのがconfig。これで設定することで、キーペアの名前が標準のもの以外だったとしてもうまくできる

# rails編 ec2インスタンスを作った後に打つコマンド
- userを作る
- authorized_keysを作る
- rubyの環境構築
  - ```
    sudo yum install \
    git make gcc-c++ patch \
    openssl-devel \
    libyaml-devel libffi-devel libicu-devel \
    libxml2 libxslt libxml2-devel libxslt-devel \
    zlib-devel readline-devel \
    mysql mysql-server mysql-devel \
    ImageMagick ImageMagick-devel \
    epel-release
    ```
  - `sudo yum install nodejs npm --enablerepo=epel`
  - `git clone https://github.com/sstephenson/rbenv.git ~/.rbenv `
  - `echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile `
  - `echo 'eval "$(rbenv init -)"' >> ~/.bash_profile`
  - `source .bash_profile`
  - `git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build`
  - `rbenv rehash`
  - `rbenv install -v （インストールしたいrubyのバージョンを指定）`
  - `rbenv global x.y.z`
  - `rbenv rehash`
  - `ruby -v` で確認
  - `[user|~] vim .gitconfig`
  - ```
    [user]
      name = keisukee
      email = kog71903@gmail.com
    [alias] #これはお好きに
      a = add
      b = branch
      ch = checkout
      st = status
    [color] #色付け
      ui = true
    [url "github:"] #pull、pushのための設定
      InsteadOf = https://github.com/
      InsteadOf = git@github.com:
    ```
  - `cd /`
  - `sudo chown keisuke var`
  - `cd var`
  - `sudo mkdir www`
  - `sudo chown keisuke www`
  - `cd www`
  - `sudo mkdir rails`
  - `sudo chown keisuke rails`
  - `cd ~/.ssh`
  - `[user|.ssh] ssh-keygen -t rsa`
  - `ファイルの名前を記述してEnter`
  - `lsで秘密鍵と公開鍵が生成されていることを確認`
  - `vim configにて下記の内容を貼り付ける`
  - ```
  Host github
  Hostname github.com
  User git
  IdentityFile ~/.ssh/aws_git_rsa (#秘密鍵の名前)
    ```
  - `chmod 600 config`権限を変更
  - `cat hogehoge_rsa.pubで公開鍵を出力し、githubに登録する`
  - `ssh -T github`でgithubに接続できることを確認
  - ``
- githubにssh接続できるように鍵を生成

# エラー対応
- パッケージ mysql-serverは利用できません
Amazon linux の場合に発生するかもしれない現象。デフォルトで入ってるMariaDBと競合しているっぽい。
```
$ sudo yum remove mariadb-libs
$ sudo yum install mysql mysql-server mysql-devel
$ sudo yum localinstall http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
$ sudo yum -y install mysql-community-server
```

- nginxの設定ファイルが存在しない時
```
$ sudo amazon-linux-extras install nginx1.12
$ nginx -v
```

# デプロイ時に叩くコマンド
```
1.PIDの確認
ps -ef | grep unicorn | grep -v grep

2.unicornの停止
kill [PID]

3.unicornが停止していることを確認
ps -ef | grep unicorn | grep -v grep

4.すでに生成されたプリコンパイルファイルの削除
bundle exec rake assets:clobber RAILS_ENV=production

5.プリコンパイルの実行
rake assets:precompile RAILS_ENV=production

6.unicornの再起動
unicorn_rails -c /var/www/rails/App_name/config/unicorn.conf.rb -D -E production

7.再起動していることを確認
ps -ef | grep unicorn | grep -v grep

8.nginxの再起動
sudo nginx -s reload

9.ブラウザで静的IPにアクセス
→ HTTP ERROR 500と表示される

10.log/nginx.error.log確認
→config/secrets.ymlのSECRET_KEY_BASEがうまくセットされていない旨が書かれていた

11.改めて、SECRET_KEY_BASEをセット (ここはなくてもいけるかも)
SECRET_KEY_BASE= 適宜記入
export SECRET_KEY_BASE
env | grep SECRET_KEY_BASE
```
# gitignoreの書き方
https://www.gitignore.io/api/rails
をコピって来れば良し

特にrailsプロジェクトでは、
/vendor/bundle
をignoreすること。でないとaddするファイル数が膨大になる

# add stage 取り消し
git reset HEAD sample.txt

でaddする前の状態になる。ファイルの内容は元のままなので安心。

# commit 取り消し 打ち消し 上書き
## 取り消し
$ git reset --hard HEAD
option
- --hard:コミット取り消した上でワークディレクトリの内容も書き換えたい場合に使用
- --soft:ワークディレクトリの内容はそのままでコミットだけを取り消したい場合に使用

## 打ち消し
$ git revert コミットのハッシュ値

## 上書き
git commit --amend

## remote urlを確認
git remote -v

# 一旦保存 stash
git stash -> diffを保存
git stash list ->stashのlistを表示
git stash drop stash@{0} -> stash のlistを削除
git stash apply stash@{0} -> stashを適用

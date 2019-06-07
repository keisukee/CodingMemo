# サンプル集
## Nested Items
- nest1
  - nested item1
- nest2
  - nested item2
    - nested item2_1
    - nested item2_1
## Number List
1. number list1
  1. nested number list1
    1. nested nested number list1
  2. nested number list2
2. number list2
3. number list3
#### To quote
Steve Jobs said
> We're here to put a dent in the universe.

太宰治 人間失格
> 恥の多い生涯を送ってきました。

## To put inline code
some code here
install command is `gem install hoge`

## To emphasize
- italic

normal here *italic here*.

normal here _italic here_.

- bold

normal here **bold here**.  
normal here __bold here__.

- italic & bold

normal here ***italic&bold here***.

normal here ___bold here___.

## 水平線
- horizontal line

---
or
***


## Expressions
~~取り消したい~~

## コードを出力したい時
```ruby:test.rb
def greeting
  puts 'Hello world!!!'
end

```
###### 様々な表現集
- to change line

spaceを2個入れる  
こんな感じで。
もしくは、単純に`<br>`を使う。<br>
改行できた。

- to insert table

テーブルをぶち込む

a|b|c
--|---|--
d|e|f
g|h|i

- 数式を出力したいとき

エディターはAtom  
Atomで数式を出力したい場合、  
markdown-preview-plus    
というパッケージを入れ、settingsで、math equationみたいなところにチェックを入れる。で、内臓のmarkdown-previewをdisableすると、latexみたいに数式がヌルヌル出せる。


https://qiita.com/kouichi-c-nakamura/items/5b04fb1a127aac8ba3b0  
を参照した。

こんな感じ
$$
e^{\pi i} = cos\theta + isin\theta
$$


$$
E  = mc^2
$$


**実に美しい！！！**
- 色々と数式を出力してみる

基本はlatexと同じ。  

$$
S_n = a_1 + a_2 + \cdot \cdot \cdot + a_n\\

\Pi_n = b_1 \cdot b_2 \cdot \cdot \cdot b_n\\

cos2\theta = cos^2\theta - sin^2\theta\\
x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}

$$


Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

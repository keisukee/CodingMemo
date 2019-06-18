# 定義リスト dl dt dd
- dl: description list
- dt: description term
- dd: definition description

%dl
  %dt fruits
  %dd apple
  %dd banana
  %dd orange

# スタイルの各順番
display
color
font-size
font-weight
font系
background系
border系
padding
margin
position

# media query slim haml
- sass
@media (max-width: 769px)
  body
    font-size: 15px

# media query sp なぜかスマホビューだけ適応されない
viewportの記述が必要かもしれない。Media Queries を適用しているCSSを読み込んでいるHTMLのヘッド部分に以下の一行を追加してあげればOK
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

# background image-url 画像 背景
background: #AAA image-url("/videos/show/play_button.png") center center/ 100px 100px

# table
<table>
  <tr>
    <th>無料プラン</th>
    <th class="popular"><span class="inner"><span class="no1">人気No.1</span>初級プラン</span></th>
    <th>上級プラン</th>
  </tr>
  <tr>
    <td>¥0</td>
    <td class="popular">¥5,000</td>
    <td>¥8,000</td>
  </tr>
</table>

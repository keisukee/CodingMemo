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
      <thead>
        <tr>
          <th>Name</th>
          <th>University</th>
          <th>Birthday</th>
          <th>Github</th>
          <th>Twitter</th>
          <th>Mail</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>大橋 啓介(Keisuke Ohashi)</td>
          <td>早稲田大学 基幹理工学部 情報工学科</td>
          <td>1998年9月17日</td>
          <td>
            <a href="https://github.com/keisukee">Github</a>
          </td>
          <td>
            <a href="https://twitter.com/sukebeeeeei">@sukebeeeeei</a>
          </td>
          <td>kog71903[at]gmail.com</td>
        </tr>
      </tbody>
    </table>

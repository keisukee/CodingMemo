# export import
```person.js
const person = 'hoge'
export default person
```
```utility.js
export const clean = () => {}
export const baseData = 100;
```
```app.js
import person from './person.js'
import prs from './person.js'

import { baseData } from './utility.js'
import { baseData as data } from './utility.js'
import { clean } from './utility.js'
```
export時にdefaultと指定すると、ファイルをimportするときにはそれが勝手に指定される。これに対し、default指定をしない場合は、importするときに{}内で読み込むコンポーネントを明示的に指名する必要がある。


# create-react-app
今では`npm create-react-app hogehoge`は使えなくなったので、`npx create-react-app your_app_name`を使う


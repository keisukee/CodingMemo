# 開始
```
起動：sudo service mongodb start
停止：sudo service mongodb stop
```

# シェル起動
`$ mongo`
# db一覧
`show dbs;`
# データベース作成
`use study` // studyデータベースを作成

# データ作成
```
db.user.insert({name:'mr.a', age:10, gender:'m', hobbies:['programming']});
db.user.insert({name:'mr.b', age:20, gender:'m', hobbies:['vi']});
db.user.insert({name:'ms.c', age:30, gender:'f', hobbies:['programming', 'vi']});
db.user.insert({name:'ms.d', age:40, gender:'f', hobbies:['cooking']});
```

# find
```
db.user.find()
{ "_id" : ObjectId("53be9d74b7fe1603319861e8"), "name" : "mr.a", "age" : 10, "gender" : "m", "hobbies" : [  "programming" ] }
{ "_id" : ObjectId("53be9d74b7fe1603319861e9"), "name" : "mr.b", "age" : 20, "gender" : "m", "hobbies" : [  "vi" ] }
{ "_id" : ObjectId("53be9d74b7fe1603319861ea"), "name" : "ms.c", "age" : 30, "gender" : "f", "hobbies" : [  "programming",  "vi" ] }
{ "_id" : ObjectId("53be9d74b7fe1603319861eb"), "name" : "ms.d", "age" : 40, "gender" : "f", "hobbies" : [  "cooking" ] }
```

# database情報
`db.stats();`
# database削除
`db.dropDatabase();`
# Collection一覧
`show collections;`
# Collection名を変更 users->customers
`db.users.renameCollection("customers");`
# Collection削除
`db.hoge.drop();`
# irbで対話形式で作成したプログラムを検証する
`require "./sample.rb"`でsample.rbが使えるようになる

# あるオブジェクトの継承クラスや使えるメソッドが知りたい時
irbを開く

## クラスなどを知りたい
```
$ hoge = "hgoeij"

irb(main):004:0> hoge.class
=> String

irb(main):007:0> hoge.class.ancestors
=> [String, Comparable, Object, Kernel, BasicObject]
```

## メソッドなどを知りたい
```
hoge.methods
=> [:include?, :%, :unicode_normalize, :*, :+, :unicode_normalize!, :to_c, :unicode_normalized?, :count, :partition, :unpack, :encode, :encode!, :next, :casecmp, :insert, :bytesize, :match, :succ!, :next!, :upto, :index, :rindex, :replace, :clear, :chr, :+@, :-@, :setbyte, :getbyte, :<=>, :<<, :scrub, :scrub!, :byteslice, :==, :===, :dump, :=~, :downcase, :[], :[]=, :upcase, :downcase!, :capitalize, :swapcase, :upcase!, :oct, :empty?, :eql?, :hex, :chars, :split, :capitalize!, :swapcase!, :concat, :codepoints, :reverse, :lines, :bytes, :prepend, :scan, :ord, :reverse!, :center, :sub, :freeze, :inspect, :intern, :end_with?, :gsub, :chop, :crypt, :gsub!, :start_with?, :rstrip, :sub!, :ljust, :length, :size, :strip!, :succ, :rstrip!, :chomp, :strip, :rjust, :lstrip!, :tr!, :chomp!, :squeeze, :lstrip, :tr_s!, :to_str, :to_sym, :chop!, :each_byte, :each_char, :each_codepoint, :to_s, :to_i, :tr_s, :delete, :encoding, :force_encoding, :sum, :delete!, :squeeze!, :tr, :to_f, :valid_encoding?, :slice, :slice!, :rpartition, :each_line, :b, :ascii_only?, :to_r, :hash, :<, :>, :<=, :>=, :between?, :instance_of?, :public_send, :instance_variable_get, :instance_variable_set, :instance_variable_defined?, :remove_instance_variable, :private_methods, :kind_of?, :instance_variables, :tap, :define_singleton_method, :is_a?, :public_method, :extend, :singleton_method, :to_enum, :enum_for, :!~, :respond_to?, :display, :object_id, :send, :method, :nil?, :class, :singleton_class, :clone, :dup, :itself, :taint, :tainted?, :untaint, :untrust, :trust, :untrusted?, :methods, :protected_methods, :frozen?, :public_methods, :singleton_methods, :!, :!=, :__send__, :equal?, :instance_eval, :instance_exec, :__id__]
```

## メソッドの中から特定のものを検索する
```
irb(main):018:0> hoge.methods.grep(/^i.*l$/)
=> [:instance_eval]  # grepの//の中は正規表現。`^`は文字の始まり、.*は任意の文字が任意の回数登場、`l$`は行末がlで終わる、という意味。
```
# sendの使い方 メソッドを動的に呼び出す 動的ディスパッチ
```
➜  methods $ cat dynamic_call.rb
class MyClass
  def my_method(my_arg)
    my_arg * 2
  end

  define_method :my_method2 do |my_arg|
    my_arg * 30
  end
end
➜  methods $ irb
irb(main):001:0> require "./dynamic_call.rb"
=> true
irb(main):002:0> obj = MyClass.new
=> #<MyClass:0x007fe023a7ccf8>
irb(main):003:0> obj.my_method(4)
=> 8
irb(main):004:0> obj.send(:my_method, 10)
=> 20
```

# %記法
%(a b c)
=> "a b c"

%w(a b c)
 => ["a", "b", "c"]

%i(a b c)
  => [:a, :b, :c]

%r(^http://)
  => /^http:\/\//

# ブロック構文 do end
下の二つの構文は等価
```
numbers.each do |n|
  sum += n
end
```

```
numbers.each { |n| sum += n }
```

# map/collect文
```
numbers = [1, 2, 3, 4, 5]

new_numbers = []

numbers.each { |n| new_numbers << n * 10 }
p new_numbers

new_numbers = numbers.map { |n| n * 100 }
p new_numbers

->
[10, 20, 30, 40, 50]
[100, 200, 300, 400, 500]
```

# select/find_all/reject文
```
numbers = [1, 2, 3, 4, 5, 6]

even_numbers = numbers.select { |n| n.even? }
odd_numbers = numbers.select { |n| n.odd? }
p even_numbers
p odd_numbers

->
[2, 4, 6]
[1, 3, 5]
```

# inject/reduce
```
numbers = [1, 2, 3, 4]
sum = 0
numbers.each { |n| sum += n }
p sum

sum = numbers.inject(0) { |result, n| result + n }
p sum
```
ブロックの戻り値が次回に引き継がれ、第一引数に入る。第二引数には配列の各要素が入る
初回のループだけinjectの引数（この場合は0）が使われる。
つまり、
1回目 result = 0, n = 1, 0 + 1 = 1が次のresultの値
2回目 result = 1, n = 2, 1 + 2 = 3
3回目 result = 3, n = 3, 3 + 3 = 6
4回目 result = 6, n = 4, 6 + 4 = 10が最終的な返り値

# hash ハッシュ
```
hash = { 'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }

p hash
p hash['japan'] # -> "yen"

hash.each do |key, value|
  p "#{key} : #{value}"
end

hash.each { |key, value| puts "#{key} : #{value}" }

hash.each do |key_value|
  key = key_value[0]
  value = key_value[0]
  p "#{key} : #{value}"
end

hash.each { |key_value|  p "#{key_value[0]} : #{key_value[1]}" }

->
{"japan"=>"yen", "us"=>"dollar", "india"=>"rupee"}
"yen"
"japan : yen"
"us : dollar"
"india : rupee"
japan : yen
us : dollar
india : rupee
"japan : japan"
"us : us"
"india : india"
"japan : yen"
"us : dollar"
"india : rupee"

```
hash文のブロック引数が二個だった場合は、|key, value|がそれぞれ入る。ブロック引数が一個だった場合は、key,valueがそれぞれ|key_value|の配列の一番目、二番目として得られる。つまり、key = key_value[0], value = key_value[1]

# symbol
```
p :apple.class # Symbol
p :apple.object_id # 899868
p :apple.object_id # 899868 一致　-> イミュータブル（変更不可）
p 'apple'.object_id # 70243171150940
p 'apple'.object_id # 70243171150860 -> 値が違う -> ミュータブル（変更可能）

symbol = { :japan => 'yen', :us => 'dollar', :india => 'rupee' }
symbol2 = { japan: 'yen', us: 'dollar', india: 'rupee' }
symbol3 = { japan: :yen, us: :dollar, india: :rupee }
symbol4 = { :japan => :yen, :us => :dollar, :india => :rupee }

p symbol # {:japan=>"yen", :us=>"dollar", :india=>"rupee"}
p symbol[:japan] #{ }"yen"

p symbol2 # {:japan=>"yen", :us=>"dollar", :india=>"rupee"}
p symbol2[:us] #{ }"dollar"

p symbol3 # {:japan=>:yen, :us=>:dollar, :india=>:rupee}
p symbol3[:us] # :dollar

p symbol4 # {:japan=>:yen, :us=>:dollar, :india=>:rupee}
p symbol4[:us] # :dollar
```

# block yield
```def greeting
  puts 'おはよう'
  text = yield 'hello hello'
  puts text
  puts 'こんばんは'
end

greeting do |text|
  text * 4
end


def greeting2(&block)
  puts 'good morning'
  text = block.call('こんにちは')
  puts text
  puts 'good night'
end

greeting2 do |text|
  text * 2
end
```

# proc Proc call
```
hello_proc = Proc.new do
  p 'hello!'
end

thank_proc = Proc.new { p 'Thank you!' }

add_proc = Proc.new { |a, b| p a + b }

hello_proc.call
thank_proc.call
add_proc.call(2, 5)

```
# block proc Proc
Procオブジェクトをブロックの代わりに渡す際は&をつける。
```
def greeting(&block)
  puts 'おはよ'
  text = block.call('hello')
  puts text
  puts 'おやすみ'
end

repeat_proc = Proc.new { |text| text * 2 }
greeting(&repeat_proc)
```

# lambda ラムダ式
```
add_proc = Proc.new{ |a, b| p a + b }
add_proc.call(3, 5)

substract_proc = proc { |a, b| p a - b }
substract_proc.call(3, 5)

multiply_lambda = ->(a, b) { p a * b }
multiply_lambda2 = -> a, b { p a * b }
multiply_lambda3 = ->(a, b) do
  p a * b
end

multiply_lambda.call(3, 5)
multiply_lambda2.call(3, 5)
multiply_lambda3.call(3, 5)

divide_lambda = lambda { |a, b| p a / b }
divide_lambda.call(3, 5.0)
```
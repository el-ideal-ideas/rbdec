# RbDec

Pythonのデコレーターのような機能をできる限りRubyで実現したGem
(メソッドの実行の前後に別で定義した機能を付けることができる)

## インストール

Gemfileに下記の記述を追加

```ruby
gem 'rbdec'
```

下記のコマンドを実行

    $ bundle install

または

    $ gem install rbdec

## 使い方

#### 注意
- デコレートされる側はクラスに属するメソッドである必要がある。
- デコレーター用関数はクラスの外で宣言する必要がある。

#### シンプルな例

```ruby
def before(param, *t_param, &t_block)
  puts 'This is the before method.'
  [true, nil, t_param, t_block]
end

def after(res, param, *t_param, &t_block)
  puts 'This is the after method.'
end

class Example
  extend RbDec
  decorate :foo, before_dec: method(:before), after_dec: method(:after)
  def foo
    puts "This is the foo method."
  end
end

Example.new.foo

# 出力
# 
# This is the before method.
# This is the foo method.
# This is the after method.
# 
```

#### 引数と返り値を改変する例

```ruby
def before(_param, *t_param, &t_block)
  t_param[0] *= 2
  [true, nil, t_param, t_block]
end

def after(res, _param, *_t_param, &_t_block)
  "T#{res}"
end

class Sample
  extend RbDec
  decorate :test, before_dec: method(:before), after_dec: method(:after)

  def test(cnt)
    "TEST" * cnt
  end
end

puts Sample.new.test(2)
# TTESTTESTTESTTEST
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rbdec project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rbdec/blob/master/CODE_OF_CONDUCT.md).

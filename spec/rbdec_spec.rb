# frozen_string_literal: true

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


RSpec.describe RbDec do
  it "バージョンが記述されていること" do
    expect(RbDec::VERSION).not_to be nil
  end

  it "デコレーターの機能を試す" do
    obj = Sample.new
    expect(obj.test(2)).to eq("T#{"TEST" * 4}")
  end
end

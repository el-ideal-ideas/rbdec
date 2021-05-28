# frozen_string_literal: true

require_relative "rbdec/version"

# Pythonのデコレーター機能をRubyでの実現を試みる
module RbDec
  def decorate(name, param = nil, before_dec: nil, after_dec: nil)
    to_prepend = Module.new do
      define_method(name) do |*t_param, &t_block|
        # -- Before --
        if before_dec.respond_to?('call')
          status, result, r_param, r_block = before_dec.call(param, *t_param, &t_block)
        else
          status, result, r_param, r_block = true, nil, t_param, t_block
        end
        # -- Call --
        if status
          res = super(*r_param, &r_block)
        else
          res = result
        end
        # -- After --
        if after_dec.respond_to?('call')
          after_dec.call(res, param, *t_param, &t_block)
        else
          res
        end
      end
    end
    prepend to_prepend
  end
end

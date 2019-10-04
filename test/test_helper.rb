#require 'simplecov'
#SimpleCov.start do
#  add_filter '/test/'
#end

require "combustion"
Combustion.path = "test/internal"
Combustion.initialize! :all

require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/benchmark'

def reset_order
  Order.act_with_flags.reset  if Order.act_with_flags
end

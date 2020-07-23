if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/test/'
  end
end

require "combustion"
Combustion.path = "test/internal"
Combustion.initialize! :active_record

require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/benchmark'
#require 'capybara/rails'

def reset_order
  Order.act_with_flags.reset  if Order.act_with_flags
end

#require 'simplecov'
#SimpleCov.start do
#  add_filter 'test'
#end

require "combustion"
Combustion.path = "test/internal"
Combustion.initialize! :all

require 'rubygems'
require 'minitest/autorun'
require 'minitest/benchmark'

=begin
require 'active_record'
require_relative '../lib/act_with_flags.rb'

ENV['RAILS_ENV'] ||= 'test'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/flags.sqlite3'
)

ActiveRecord::Schema.define do
  create_table 'orders', force: true do |t|
    t.integer :flags
    t.string  :bigflags
    t.integer :category
  end
end

class Order < ActiveRecord::Base
  before_create { |row|
    row.flags ||= 0
    row.bigflags ||= ''
  }
end

def reset_order
  Order.act_with_flags.reset  if Order.act_with_flags
end
=end

# rubocop:disable all

if ENV['MORE']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'test'
  end
end

require 'rubygems'
require 'minitest/autorun'
require 'minitest/benchmark'
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
    t.string  :bigflaags
    t.string  :category
  end

  create_table 'users', force: true do |t|
    t.string :type
    t.text   :bag
  end
end

class Order < ActiveRecord::Base
end

def reset_order
  Order.add_to_flags reset: :hard
end

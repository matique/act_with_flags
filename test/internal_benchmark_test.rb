# For development purposes; do not waste your tine reading it!
# YAGNI
# rubocop:disable all

require 'test_helper'
require 'benchmark'
require 'benchmark/ips'
# ENV['MORE'] = 'true'

describe 'Internal timings' do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_flags :blocked
  end

  it 'times ips' do
    return  unless ENV['MORE']

    Order.add_to_flags :blocked, reset: :hard
    order = Order.new

    Benchmark.ips do |x|
      x.report('assign true : ')        { order.blocked = true }
      x.report('assign false: ')        { order.blocked = false }
      x.report('assign "false": ')      { order.blocked = 'false' }
      x.report('x = order.blocked? ')   { x = order.blocked? }
      x.report('x = order.blocked ')    { x = order.blocked }

      x.compare!
    end
  end

end

class BenchFoo < Minitest::Benchmark

  def bench_order_blocked
    return  unless ENV['MORE']

    n = 1_000_000
    n = 100_000
    n = 10_000
    Order.add_to_flags :blocked, reset: :hard
    order = Order.new
    assert_performance_constant do |input|
      n.times do
        order.blocked = true
        order.blocked = !order.blocked
      end
    end
  end

end

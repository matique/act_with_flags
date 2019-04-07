# For development purposes; do not waste your tine reading it!
# YAGNI
# rubocop:disable all

require 'test_helper'
require 'benchmark'
require 'benchmark/ips'
# ENV['MORE'] = 'true'

describe 'Internal timings' do
  let(:order) { Order.create }

  def setup
    reset_order
    Order.add_to_flags :blocked
  end

  it 'times ips' do
    return  unless ENV['MORE']

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
    Order.add_to_flags :blocked2
    order = Order.create
    assert_performance_constant do |input|
      n.times do
        order.blocked2 = true
        order.blocked2 = !order.blocked2
      end
    end
  end

end

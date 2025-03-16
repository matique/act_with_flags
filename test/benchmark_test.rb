# For development purposes; do not waste your tine reading it!
# YAGNI

require "test_helper"
require "benchmark"
require "benchmark/ips"
# ENV["MORE"] = "true"

describe "Internal timings" do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_flags :blocked
  end

  it "times ips" do
    return unless ENV["MORE"]

    Benchmark.ips do |x|
      x.report("assign true : ") { order.blocked = true }
      x.report("assign false: ") { order.blocked = false }
      x.report("assign \"false\": ") { order.blocked = "false" }
      x.report("x = order.blocked? ") { x = order.blocked? }
      x.report("x = order.blocked ") { x = order.blocked }

      x.compare!
    end
  end
end

describe "Internal timings mask" do
  let(:order) { Order.new }
  let(:admin) { Order.act_with_flags }

  def setup
    reset_order
    Order.add_to_flags a: 1, b: 7, c: 3
    # Order.add_to_flags a: 1, b: 60, c: 3
    # Order.add_to_flags a: 1, b: 1000, c: 3
  end

  it "times ips" do
    return unless ENV["MORE"]

    Benchmark.ips do |x|
      x.report("mask(:a, :b):  ") { admin.mask(:a, :b) }
      x.report("any?(:a, :b):  ") { order.flags_any?(:a, :b) }
      x.report("all?(:a, :b):  ") { order.flags_all?(:a, :b) }
      x.report("none?(:a, :b): ") { order.flags_none?(:a, :b) }

      x.compare!
    end
  end
end

class BenchFoo < Minitest::Benchmark
  def bench_order_blocked
    return unless ENV["MORE"]
    n = 10_000
    Order.add_to_flags :blocked2
    order = Order.new
    assert_performance_constant do |input|
      n.times do
        order.blocked2 = true
        order.blocked2 = !order.blocked2
      end
    end
  end
end

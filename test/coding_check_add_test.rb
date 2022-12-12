require "test_helper"

describe "Internal check add_to_" do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_flags a: 1, b: 7
  end

  it "skips reserved position" do
    Order.add_to_flags :xx
    order.xx = true
    assert_equal 0x100, order.flags

    Order.add_to_flags :yy
    order.yy = true
    assert_equal 0x300, order.flags
  end

  it "rejects redefinition" do
    Order.add_to_flags :z
    assert_raises { Order.add_to_flags :z }
  end

  it "rejects reuse of position" do
    assert_raises { Order.add_to_flags qq: 1 }
  end
end

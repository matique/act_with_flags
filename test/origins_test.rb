require "test_helper"

describe "Several origins" do
  let(:order) { Order.create }

  def setup
    reset_order
    Order.add_to_flags :a # origin is :flags
    Order.add_to_flags :b, b2: 63 # origin is :flags
    Order.add_to_flags :c, origin: :origin1
    Order.add_to_flags d: 3, origin: :origin2
    Order.add_to_flags :d2, origin: :origin2
  end

  it "checks flags" do
    order.a = true
    order.b = true
    order.b2 = true
    assert_equal 0x8000000000000003, order.flags
    order.b2 = false
    assert_equal 0x03, order.flags
    assert_equal 0x01, Order.act_with_flags.mask(:a) # should work
    assert_equal 0x8000000000000002, Order.act_with_flags.mask(:b, :b2) # should work
  end

  it "checks origin1" do
    order.c = true
    assert_equal 0x01, order.origin1
    assert_equal 0x01, Order.act_with_flags.mask(:c)
  end

  it "checks origin2" do
    order.d = true
    assert_equal 0x08, order.origin2
    assert_equal 0x18, Order.act_with_flags.mask(:d2, :d)
  end

  it "should reject mask for different origins" do
    assert_raises(RuntimeError) {
      Order.act_with_flags.mask :c, :d
    }
  end

  it "allows any? et all for same origins" do
    order.flags_any? :b, :b2
    order.flags_all? :d2, :d
  end

  it "rejects any? et all for different origins" do
    assert_raises(RuntimeError) {
      order.flags_any? :a, :c
    }
    assert_raises(RuntimeError) {
      order.flags_all? :d2, :c
    }
  end
end

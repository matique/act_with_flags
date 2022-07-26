require "test_helper"

class A < Order
  add_to_flags x: 1, y: 2
end

describe "inheritance" do
  let(:a) { A.create }

  def setup
    reset_order
    Order.add_to_flags z: 3
  end

  it "consistency" do
    assert a.respond_to?(:x)
    assert a.respond_to?(:y)
    assert_equal false, a.x
    assert_equal false, a.y
    a.y = true
    assert_equal true, a.y
  end

  it "checks any?" do
    a.x = true
    assert a.flags_any?(:x, :y)

    assert_raises(RuntimeError) {
      assert a.flags_any?(:x, :y, :z)
    }
  end
end

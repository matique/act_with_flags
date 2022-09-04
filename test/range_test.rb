require "test_helper"

describe "range" do
  def setup
    reset_order
  end

  it "runs without range" do
    Order.add_to_flags :a
    Order.add_to_flags :b
  end

  it "runs with range(inside)" do
    Order.add_to_flags range: 2..4, a: 2
    Order.add_to_flags range: 2..4, b: 3
  end

  it "fails with outside range" do
    assert_raises(RangeError) { Order.add_to_flags range: 2..3, a: 1 }
    assert_raises(RangeError) { Order.add_to_flags range: 2..3, b: 4 }
  end

  it "runs at borders" do
    Order.add_to_flags range: 2..3, a: 2
    Order.add_to_flags range: 2..3, b: 3
  end

  it "runs with ... as range" do
    Order.add_to_flags range: 2...3, a: 2
    assert_raises(RangeError) { Order.add_to_flags range: 2...3, b: 3 }
  end

  it "detects wrong range" do
    assert_raises(RangeError) { Order.add_to_flags range: "a".."z", a: 2 }
  end

  it "tests range 0..0 no position" do
    Order.add_to_flags :a, range: 0..0
    assert_raises(RangeError) { Order.add_to_flags :b, range: 0..0 }
  end

  it "tests range ..0 no position" do
    Order.add_to_flags :a, range: ..0
    assert_raises(RangeError) { Order.add_to_flags :b, range: ..0 }
  end

  it "tests range ...0 no position" do
    assert_raises(RangeError) { Order.add_to_flags :a, range: ...0 }
  end
end

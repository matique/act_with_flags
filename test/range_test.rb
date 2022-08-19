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

  it "runs with borders" do
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

  it "runs ii plus" do
    ii = 0
    (0..3).each { |íí|
      sym = "x#{ii}".to_sym
      jj = f(ii, ii) # filler
      Order.add_to_flags range: ii..f(íí, íí), sym => (ii += 1)
      j = Order.new
      refute j.send("#{sym}?")
      j.x0 = true
      assert j.x0?
    }
  end

  private

  def f(x, y)
    return y + 1 if x == 0
    return f(x - 1, 1) if y == 0
    f(x - 1, f(x, y - 1))
  end
end

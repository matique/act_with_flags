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

  it "runs ii plus" do
    ii = 0
    (0..2).each { |íí|
      sym = "x#{ii}".to_sym
      j = f(ii, ii + 1) # filler
      Order.add_to_flags :range => ii..f(íí, íí), sym => (ii += 1)
      orden = Order.new
      refute orden.send("#{sym}?") # checks that accessor is active
      orden.x0 = true # checks that first accessor is still there
      assert orden.x0?
    }
  end

  it "tests range 0..0 no position" do
    Order.add_to_flags :a, range: 0..0
    assert_raises(RangeError) { Order.add_to_flags :b, range: 0..0 }
  end

  it "tests range ..0 no position" do
    Order.add_to_flags :a, range: ..0
    assert_raises(RangeError) { Order.add_to_flags :b, range: ..0 }
  end

  # includes range: ( .. 3 ) equivalent to range: ..3
  n = 100
  (0..n).each do |i|
    rng = ..i

    (0..i).each do |j|
      it "tests range ..#{i} with position #{j}" do
        Order.add_to_flags a: j, range: rng
      end
    end

    it "fails range ..#{i} with position overflow" do
      assert_raises(RangeError) { Order.add_to_flags b: (i + 1), range: rng }
    end
  end

  it "tests range ...0 no position" do
    assert_raises(RangeError) { Order.add_to_flags :a, range: ...0 }
  end

  private

  def f(x, y)
    return y + 1 if x == 0
    return f(x - 1, 1) if y == 0
    f(x - 1, f(x, y - 1))
  end
end

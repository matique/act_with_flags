require "test_helper"

describe "range #3" do
  def setup
    reset_order
  end

  it "accepts an integer as position" do
    Order.add_to_flags a: 0
    Order.add_to_flags b: 1
    Order.add_to_flags c: 2
    Order.add_to_flags d: 100

    msk = Order.add_to_flags.mask(:a, :b, :c)
    assert 0x07, msk

    msk = Order.add_to_flags.mask(:d)
    assert 0x10000000000000000000000000, msk
  end

  it "rejects negative position" do
    assert_raises(ArgumentError) { Order.add_to_flags a: -1 }
  end

  it "rejects a symbol as position" do
    assert_raises(ArgumentError) { Order.add_to_flags a: :a_symbol }
  end

  [0..0, 0..1, ..0, 1.., 100..100, 0...1, ...1, 1..., ...100].each do |range|
    it "checks valid range #{range}" do
      Order.add_to_flags range: range
    end
  end

  [-1..0, :a..:z, "a".."z"].each do |range|
    it "rejects invalid range #{range}" do
      assert_raises(RangeError) { Order.add_to_flags range: range }
    end
  end
end

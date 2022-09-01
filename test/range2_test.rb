require "test_helper"

describe "range #2" do
  def setup
    reset_order
  end

  it "succeeds specifying just a range" do
    Order.add_to_flags range: 0...0
  end

  it "succeeds specifying just a (same) range with an origin" do
    Order.add_to_flags range: 0..0
    Order.add_to_flags range: 0..0, origin: :dummy
  end

  it "rejects more than one range specification" do
    Order.add_to_flags range: 0..0
    assert_raises(ArgumentError) { Order.add_to_flags range: 1..1 }
  end

  it "succeeds validation (pre specification of range)" do
    Order.add_to_flags range: ..0
    Order.add_to_flags :a
  end

  it "succeeds validation (post specification of range)" do
    Order.add_to_flags :a
    Order.add_to_flags range: ..0
  end

  it "fails validation (pre specification of range)" do
    Order.add_to_flags range: (1..)
    assert_raises(RangeError) { Order.add_to_flags :a }
  end

  it "fails validation (post specification of range)" do
    Order.add_to_flags :b, origin: :hugo
    Order.add_to_flags :a
    assert_raises(RangeError) { Order.add_to_flags range: 1.. }
  end

  it "succeeds validation for two flags (post specification of range)" do
    Order.add_to_flags :a, :b # bits 0 & 1
    Order.add_to_flags range: ..1
  end

  it "rejects validation for two flags (post specification of range)" do
    Order.add_to_flags :a, :b # bits 0 & 1
    # :a (bit 0) triggers an exception on the validation of range
    assert_raises(RangeError) { Order.add_to_flags range: 1.. }
  end

  it "rejects post validation" do
    Order.add_to_flags :a, :b # bits 0 & 1
    # :b (bit 1) triggers an exception on the validation of range
    assert_raises(RangeError) { Order.add_to_flags range: ..0 }
  end
end

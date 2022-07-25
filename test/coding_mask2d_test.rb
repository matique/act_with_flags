require "test_helper"

class B < Order
  add_to_flags x: 1
end

describe "mask2d" do
  let(:admin) { B.act_with_flags }

  def setup
    reset_order
    Order.add_to_flags y: 2
  end

  it "is a non splitted mask" do
    mask = admin.mask2d(:x)
    assert_equal 1, mask.length
  end

  it "is a splitted mask" do
    mask = admin.mask2d(:x, :y)
ic mask
    assert_equal 2, mask.length
  end
end

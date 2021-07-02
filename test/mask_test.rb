require "test_helper"

describe "mask" do
  let(:admin) { Order.act_with_flags }

  def setup
    reset_order
    Order.add_to_flags a: 1, b: 7, c: 3
  end

  it "mask empty" do
    assert_equal 0x00, admin.mask
  end

  it "mask of one flag" do
    assert_equal 0x80, admin.mask(:b)
  end

  it "mask of several flags" do
    assert_equal 0x8a, admin.mask(:a, :b, :c)
  end

  it "order is not relevant" do
    mask = admin.mask(:a, :b, :c)
    assert_equal mask, admin.mask(:c, :b, :a)
  end
end

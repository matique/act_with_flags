require "test_helper"

describe "Testing origin" do
  let(:admin) { Order.act_with_flags }
  let(:order) { Order.new }

  def setup
    reset_order
  end

  it "location category" do
    Order.add_to_flags :x, origin: :category
    assert_equal :category, admin.location(:x).first
  end

  it "origin default" do
    Order.add_to_flags :x
    assert_equal :flags, admin.location(:x).first
  end
end

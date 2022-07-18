require "test_helper"

describe "Testing reset" do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_flags :a
  end

  it "reset hard" do
    empty = {}
    refute_equal empty, Order.add_to_flags.locations

    Order.act_with_flags&.reset
    assert_equal empty, Order.add_to_flags.locations
  end
end

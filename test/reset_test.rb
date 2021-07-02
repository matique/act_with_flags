require "test_helper"

describe "Testing reset" do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_flags :a
  end

  it "reset hard" do
    refute_equal [], Order.add_to_flags.names
    Order.act_with_flags&.reset
    assert_equal [], Order.add_to_flags.names
  end
end

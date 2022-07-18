require "test_helper"

describe "Coverage" do
  let(:order) { Order.create }

  def setup
    reset_order
    Order.add_to_flags a: 1, b: 7
  end

  it "coverage to_s" do
    res = order.act_with_flags.to_s
    puts res if ENV["MORE"]
  end

  it "coverage location raise" do
    assert_raises { order.act_with_flags.location(:unknown) }
  end
end

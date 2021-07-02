require "test_helper"

describe "No Flags" do
  def setup
    reset_order
    Order.add_to_flags
  end

  it "respond to ActWithFlags API" do
    assert Order.respond_to?(:add_to_flags)
    assert Order.respond_to?(:remove_from_flags)
    assert Order.respond_to?(:clear_flags_at_save)
    assert Order.respond_to?(:act_with_flags)
  end
end

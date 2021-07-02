require "test_helper"

describe "Internal check add flag" do
  let(:admin) { Order.act_with_flags }

  def setup
    reset_order
    Order.add_to_flags a: 1, b: 7, c: 3
  end

  it "skip reserved position" do
    Order.add_to_flags :xx
    assert_equal 0, admin.position(:xx)
    Order.add_to_flags :yy
    assert_equal 2, admin.position(:yy)
  end

  it "rejects redefinition" do
    Order.add_to_flags :z
    assert_raises { Order.add_to_flags :z }
  end

  it "rejects reuse of position" do
    assert_raises { Order.add_to_flags qq: 1 }
  end

  it "coverage to_s" do
    res = admin.to_s
    puts res if ENV["MORE"]
  end

  it "coverage position raise" do
    assert_raises { admin.position(:aaaa) }
  end
end

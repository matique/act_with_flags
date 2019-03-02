require 'test_helper'

describe 'Testing origin' do
  let(:flags) { Order.act_with_flags }
  let(:order) { Order.new }

  def setup
    reset_order
  end

  it 'origin category' do
    Order.add_to_flags :x, origin: :category, reset: :hard
    assert_equal :category, flags.origin
  end

  it 'origin category #2' do
    Order.add_to_flags :x, origin: :category, reset: :hard
    assert_raises { Order.add_to_flags origin: :category2 }
  end

  it 'origin category #3' do
    Order.add_to_flags :x, origin: :category, reset: :hard
    Order.add_to_flags origin: :category
  end

  it 'origin default' do
    Order.add_to_flags :x
    assert_equal :flags, flags.origin
  end

  it 'origin 1' do
    Order.add_to_flags origin: 1
    assert_equal :flags, flags.origin
    assert order.respond_to?(:origin)
  end

end

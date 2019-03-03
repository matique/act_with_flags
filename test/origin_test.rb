require 'test_helper'

describe 'Testing origin' do
  let(:admin) { Order.act_with_flags }
  let(:order) { Order.new }

  def setup
    reset_order
  end

  it 'origin category' do
    Order.add_to_flags :x, origin: :category
    assert_equal :category, admin.origin
  end

  it 'origin category #2' do
    Order.add_to_flags :x, origin: :category
    assert_raises { Order.add_to_flags origin: :category2 }
  end

  it 'origin category #3' do
    Order.add_to_flags :x, origin: :category
    Order.add_to_flags origin: :category
  end

  it 'origin default' do
    Order.add_to_flags :x
    assert_equal :flags, admin.origin
  end

  it 'origin 1' do
    Order.add_to_flags origin: 1
    assert_equal :flags, admin.origin
    assert order.respond_to?(:origin)
  end

end

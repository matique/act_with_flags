require 'test_helper'

describe 'Clear Flags at Save' do
  let(:admin) { Order.act_with_flags }
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_flags a: 1, b: 7, c: 3
    order.a = order.b = order.c = true
  end

  it 'checks sanity' do
    assert_equal 0x8a, order.flags
    assert order.b
  end

  it 'clear flags during save' do
    Order.clear_flags_at_save :b
    order.save
    order.reload
    assert_equal 0x0a, order.flags
  end

  it 'does not remove accessor' do
    Order.clear_flags_at_save :b
    Order.respond_to? :b
  end

end

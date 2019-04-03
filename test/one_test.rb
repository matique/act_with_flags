# rubocop:disable all
require 'test_helper'

describe 'One Flag' do
  let(:flag)  { :blocked }
  let(:order) { Order.create }

  def setup
    reset_order
    Order.add_to_flags flag
  end

  it 'set flag (:blocked)' do
    order.blocked = true
    assert_equal true, order.blocked
    assert_equal true, order.blocked?

    order.blocked = 'false'
    assert_equal false, order.blocked
    assert_equal false, order.blocked?
  end

  it 'rejects redefining' do
    assert_raises { Order.add_to_flags :id }
    assert_raises { Order.add_to_flags flag }
  end

  it 'rejects redefining #2' do
    Order.add_to_flags :berta
    assert_raises { Order.add_to_flags :berta }
  end

end

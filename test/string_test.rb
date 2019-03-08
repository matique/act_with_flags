# rubocop:disable all
require 'test_helper'

describe 'String Flag' do
  let(:order) { Order.new }

  def setup
    reset_order
    order.update bigflags: '0'
    Order.add_to_flags a: 1000, origin: :bigflags
  end

  it 'set and reset flag' do
    assert order.bigflags.is_a?(String)
    order.a = true
    assert order.bigflags.is_a?(String)
    assert_equal true, order.a
    assert_equal true, order.a?

    order.a = 'false'
    assert order.bigflags.is_a?(String)
    assert_equal false, order.a
    assert_equal false, order.a?
  end

end

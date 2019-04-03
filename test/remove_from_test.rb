require 'test_helper'

describe 'Delete from Flags' do
  let(:order) { Order.create }

  def setup
    reset_order
    Order.add_to_flags a: 1, b: 7, c: 3
    order.a = order.b = order.c = true
  end

  it 'remove accessors' do
    Order.remove_from_flags :b
    assert_raises { order.b }
    refute Order.respond_to?(:b)
  end

end

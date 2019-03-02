require 'test_helper'

describe 'Delete from Flags' do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_flags a: 1, b: 7, c: 3
    order.a = order.b = order.c = true
  end

  it 'accessor removed' do
    Order.delete_from_flags :b
    assert_raises { order.b }
    refute Order.respond_to?(:b)
  end

end

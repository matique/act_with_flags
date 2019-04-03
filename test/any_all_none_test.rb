require 'test_helper'

describe 'any? all? and none?' do
  let(:order) { Order.create }

  def setup
    reset_order
    Order.add_to_flags a: 1, b: 7, c: 3
  end

  it 'checks any?' do
    order.a = true
    assert order.flags_any?(:a, :b)
    order.a = false
    refute order.flags_any?(:a, :b)
  end

  it 'checks any? #2' do
    order.b = true
    assert order.flags_any?(:a, :b)
    order.b = false
    refute order.flags_any?(:a, :b)
  end

  it 'checks all?' do
    order.a = order.b = true
    assert order.flags_all?(:a, :b)
    order.a = false
    refute order.flags_all?(:a, :b)
  end

  it 'checks none? #2' do
    order.a = order.b =  true
    refute order.flags_none?(:a, :b)
    order.a = false
    refute order.flags_none?(:a, :b)
    order.b = false
    assert order.flags_none?(:a, :b)
  end

end

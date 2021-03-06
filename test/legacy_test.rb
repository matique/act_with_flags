# rubocop:disable all
require 'test_helper'

describe 'Legacy Flag' do
  let(:order) { Order.create }

  def setup
    reset_order
    Order.add_to_flags a: 1, b: 7, c: 3
  end

  it 'set true' do
    test3 true, true, true
  end

  it 'set false' do
    test3 false, false, false
  end

  it 'set mixture' do
    test3 false, true, false
  end

  it 'set mixture #2' do
    test3 true, false, true
  end

 private
  def test3(a, b, c)
    order.a = a
    order.b = b
    order.c = c

    assert_equal a, order.a
    assert_equal b, order.b
    assert_equal c, order.c
  end

end

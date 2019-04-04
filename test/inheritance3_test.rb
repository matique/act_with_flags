require 'test_helper'

class A < Order
p 4444444444444444444
  add_to_flags y: 2
end

describe 'inheritance' do
  let(:a) { A.create }

  def setup
    reset_order
p 555555555555
    Order.add_to_flags x: 1
  end

  it 'consistency' do
    assert a.respond_to?(:x)
    assert a.respond_to?(:y)
    assert_equal false, a.x
    assert_equal false, a.y
    a.y = true
    assert_equal true, a.y
  end

  it 'checks any?' do
p 11111111111111111111
    a.x = true
    assert a.flags_any?(:x, :y)
    a.x = false
    refute a.flags_any?(:x, :y)
  end

  it 'checks any? #2' do
p 22222222222222222222
    a.y = true
    assert a.flags_any?(:x, :y)
    a.y = false
    refute a.flags_any?(:x, :y)
  end

  it 'checks all?' do
    a.x = a.y = true
    assert a.flags_all?(:x, :y)
    a.x = false
    refute a.flags_all?(:x, :y)
  end

  it 'checks none? #2' do
    a.x = a.y = true
    refute a.flags_none?(:x, :y)
    a.x = false
    refute a.flags_none?(:x, :y)
    a.y = false
    assert a.flags_none?(:x, :y)
  end

end

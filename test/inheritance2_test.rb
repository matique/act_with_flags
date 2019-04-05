require 'test_helper'

class A < Order
end

class B < Order
  add_to_flags x: 2
end

class C < Order
  before_create { |row|  row.flags2 = 0 }

  attr_accessor :flags2
  add_to_flags y: 3, origin: :flags2
end

describe 'inheritance' do
  let(:admina) { A.act_with_flags }
  let(:adminb) { B.act_with_flags }

  let(:a) { A.create }
  let(:b) { B.create }
  let(:c) { C.create }

  def setup
    reset_order
    Order.add_to_flags f: 1
  end

  it 'inheritance #1' do
    assert a.respond_to?(:flags)
    assert a.respond_to?(:f)
    assert_equal 0, a.flags
    assert_equal false, a.f
  end

  it 'inheritance #2' do
    a.f = false
    assert_equal false, a.f
    a.f = true
    assert_equal true, a.f
    assert_equal 0x02, a.flags
  end

  it 'inheritance #3' do
    assert b.respond_to?(:flags)
    assert b.respond_to?(:f)
    assert b.respond_to?(:x)
    assert_equal 0, b.flags
    assert_equal false, b.f
    assert_equal false, b.x
    b.f = true
    assert_equal true, b.f
    b.x = true
    assert_equal true, b.x
    assert_equal 0x06, b.flags
  end

  it 'inheritance #4' do
    assert c.respond_to?(:f)
    assert c.respond_to?(:y)
    assert_equal false, c.y
    c.f = true
    assert_equal true, c.f
    c.y = true
    assert_equal true, c.y
    assert_equal 0x02, c.flags
    assert_equal 0x08, c.flags2
  end

end

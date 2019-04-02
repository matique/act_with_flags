require 'test_helper'

=begin
class A < Order
  attr_accessor :flags
  add_to_flags :x
end

class B < A
end

class C < A
  attr_accessor :flags
  add_to_flags :z
end

describe 'inheritance' do
  let(:admina) { A.act_with_flags }
  let(:adminb) { B.act_with_flags }
  let(:adminc) { C.act_with_flags }

  let(:a) { A.create }
  let(:b) { B.create }
  let(:c) { C.create }

  def setup
    reset_order
    Order.add_to_flags
  end

#  it 'inheritance #1' do
#    assert a.respond_to?(:x)
#    a.x = false
##puts admina.to_s
#    assert_equal false, a.x
#    a.x = true
#    assert_equal true, a.x
#  end

  it 'inheritance #2' do
p [81, b]
    assert b.respond_to?(:x)
    a.x = false
#puts admina.to_s
#puts adminb.to_s
#puts adminc.to_s
    assert_equal false, b.x
    a.x = true
p [82, a.flags]
p [83, b.flags]
    assert_equal true, b.x
  end

#  it 'inheritance #3' do
#    assert c.respond_to?(:x)
#    assert c.respond_to?(:z)
#    assert_equal false, c.x
#    assert_equal false, c.z
#    c.x = true
#    c.z = true
#    assert_equal true, c.x
#    assert_equal true, c.z
#  end
#
#  it 'inheritance #4' do
#    assert c.respond_to?(:z)
#    c.z = false
#    assert_equal false, c.z
#    c.z = true
#    assert_equal true, c.z
#  end

end
=end

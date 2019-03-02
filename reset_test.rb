require 'test_helper'

describe 'Testing reset' do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_flags :a
  end

  it 'reset default' do
    Order.add_to_flags
    refute order.respond_to?(:reset)
  end

  it 'reset hard' do
    Order.add_to_flags reset: :hard
    refute order.respond_to?(:reset)
  end

  it 'reset 1' do
    Order.add_to_flags reset: 1
    assert order.respond_to?(:reset)
  end

  it 'reset wrong' do
    assert_raises { Order.add_to_flags reset: :a }
  end

end

require 'test_helper'

describe 'Internal Null' do
  let(:admin) { Order.act_with_flags }

  def setup
    reset_order
    Order.add_to_flags
  end

  it 'respond to act_with_flags' do
    assert Order.respond_to?(:act_with_flags)
    refute_nil Order.act_with_flags
  end

  it 'tests to_boolean' do
    assert admin.to_boolean(true)
    refute admin.to_boolean(false)
    assert_raises { admin.to_boolean(nil) }
    assert_raises { admin.to_boolean(2) }
    assert_raises { admin.to_boolean('unknown') }
  end

  it 'tests a simple administration: names' do
    refute_nil admin.names
    assert_equal [], admin.names
  end

end

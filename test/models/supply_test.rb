require 'test_helper'

class SupplyTest < ActiveSupport::TestCase
  # name
  # maximum
  # notes

  test 'new valid supply' do
    supply = Supply.new(name: 'test', maximum: 100)
    assert supply.valid?
  end

  test 'invalid supply name' do
    supply = Supply.new(name: '', maximum: 100)
    assert_not supply.valid?
  end

  test 'invalid supply max' do
    supply = Supply.new(name: 'test', maximum: nil)
    assert_not supply.valid?
  end

end

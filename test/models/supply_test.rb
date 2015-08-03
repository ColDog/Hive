require 'test_helper'

class SupplyTest < ActiveSupport::TestCase
  # name
  # maximum
  # notes

  test 'new valid supply' do
    supply = Supply.new(name: 'test')
    assert supply.valid?
  end

  test 'invalid supply name' do
    supply = Supply.new(name: '')
    assert_not supply.valid?
  end

end

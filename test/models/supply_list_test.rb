require 'test_helper'

class SupplyListTest < ActiveSupport::TestCase
  # user_id
  # supply_id
  # name
  # notes
  # shared

  setup do
    @user = users(:two)
    @supply = supplies(:two)
  end

  test 'valid supply list' do
    list = SupplyList.new(user_id: @user.id, supply_id: @supply.id, name: 'hello')
    assert list.valid?, list.errors.full_messages
  end

  test 'missing user' do
    list = SupplyList.new(user_id: nil, supply_id: @supply.id, name: 'hello')
    assert list.valid?
  end

  test 'missing supply' do
    list = SupplyList.new(user_id: @user.id, supply_id: nil, name: 'hello')
    assert_not list.valid?
  end

  test 'missing name' do
    list = SupplyList.new(user_id: nil, supply_id: @supply.id, name: '')
    assert_not list.valid?
  end


end

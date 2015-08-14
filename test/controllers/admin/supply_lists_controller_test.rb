require 'test_helper'

class Admin::SupplyListsControllerTest < ActionController::TestCase

  setup { login_admin ; request.env["HTTP_REFERER"] = 'back' }

  test 'create supply list user' do
    assert_difference 'SupplyList.count', +1 do
      post :create, supply_list: { name: '777', user_id: 2, supply_id: 1 }
    end
  end

  test 'create supply list organization' do
    assert_difference 'SupplyList.count', +1 do
      post :create, supply_list: { name: '666', organization_id: 2, supply_id: 1 }
    end
  end

  test 'destroy supply list' do
    assert_difference 'SupplyList.count', -1 do
      delete :destroy, id: supply_lists(:one).id
    end
  end

  test 'add owner' do
    supply_list = supply_lists(:one)
    post :add_owner, { id: supply_list.id, user_id: 1 }
    supply_list.reload
    assert_equal 1, supply_list.user_id
  end

  test 'add owner no id' do
    post :add_owner, { id: nil }
    assert_response :redirect
  end

  test 'remove owner' do
    supply_list = supply_lists(:one)
    post :remove_owner, { id: supply_list.id }
    supply_list.reload
    assert_equal nil, supply_list.user_id
    assert_equal nil, supply_list.organization_id
  end

  test 'remove owner no id' do
    post :remove_owner, { id: nil }
    assert_response :redirect
  end


end

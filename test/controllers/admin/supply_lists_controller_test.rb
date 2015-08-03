require 'test_helper'

class Admin::SupplyListsControllerTest < ActionController::TestCase

  setup { login_admin ; request.env["HTTP_REFERER"] = 'back' }

  test 'create supply list user' do
    request.env['HTTP_REFERER'] = 'back_to_here'
    assert_difference 'SupplyList.count', +1 do
      post :create, supply_list: { name: '777', user_id: 2, supply_id: 1 }
    end
  end

  test 'create supply list organization' do
    request.env['HTTP_REFERER'] = 'back_to_here'
    assert_difference 'SupplyList.count', +1 do
      post :create, supply_list: { name: '666', organization_id: 2, supply_id: 1 }
    end
  end

  test 'destroy supply list' do
    request.env['HTTP_REFERER'] = 'back_to_here'
    assert_difference 'SupplyList.count', -1 do
      delete :destroy, id: supply_lists(:one).id
    end
  end

end

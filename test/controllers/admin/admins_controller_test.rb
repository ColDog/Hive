require 'test_helper'

class Admin::AdminsControllerTest < ActionController::TestCase

  setup do
    login_admin
  end

  test 'get index' do
    get :index
    assert_response :success
  end

  test 'create admin' do
    assert_difference 'Admin.count', +1 do
      post :create, admin: { user_id: 1 }
    end
    assert_response :redirect
  end

end

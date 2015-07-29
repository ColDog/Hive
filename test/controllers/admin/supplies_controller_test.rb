require 'test_helper'

class Admin::SuppliesControllerTest < ActionController::TestCase

  setup { login_admin }

  test 'get index' do
    get :index
    assert_response :success
  end

  test 'get edit' do
    get :edit, id: supplies(:one)
    assert_response :success
  end

  test 'get new' do
    get :new
    assert_response :success
  end

  test 'create supply' do
    assert_difference 'Supply.count', +1 do
      post :create, supply: { name: 'organization', maximum: 10 }
    end
  end

  test 'update supply' do
    put :update, id: supplies(:one), supply: { name: 'new name' }
    supply = assigns(:supply)
    assert_equal 'new name', supply.name
  end

  test 'delete supply' do
    assert_difference 'Supply.count', -1 do
      delete :destroy, id: supplies(:one)
    end
  end

end

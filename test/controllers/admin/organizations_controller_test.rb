require 'test_helper'

class Admin::OrganizationsControllerTest < ActionController::TestCase

  setup { login_admin }

  test 'get index' do
    get :index
    assert_response :success
  end

  test 'get edit' do
    get :edit, id: organizations(:one)
    assert_response :success
  end

  test 'get new' do
    get :new
    assert_response :success
  end

  test 'create organization' do
    assert_difference 'Organization.count', +1 do
      post :create, organization: { name: 'organization', description: 'hello there' }
    end
  end

  test 'update organization' do
    put :update, id: organizations(:one), organization: { name: 'new name' }
    org = assigns(:organization)
    assert_equal 'new name', org.name
  end

  test 'delete organization' do
    assert_difference 'Organization.count', -1 do
      delete :destroy, id: organizations(:one)
    end
  end

end

require 'test_helper'
require 'devise'

class OrganizationsControllerTest < ActionController::TestCase

  test 'not logged in get index' do
    get :index
    assert_response :redirect
  end

  test 'should get index' do
    login_user
    get :index
    assert_response :success
    assert_select 'a.edit-button', 2
  end

  test 'should get index with no editing' do
    login_user_two
    get :index
    assert_response :success
    assert_select 'a.edit-button', 0
  end

  test 'admin get index' do
    login_admin
    get :index
    assert_response :success
    assert_select 'a.edit-button', Organization.count
  end

end

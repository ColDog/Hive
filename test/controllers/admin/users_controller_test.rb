require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  setup do
    login_admin
    ActionMailer::Base.deliveries.clear
  end

  test 'get index' do
    get :index
    assert_response :success
  end

  # test 'get edit' do
  #   get :edit, id: users(:one)
  #   assert_response :success
  # end

  test 'get new' do
    get :new
    assert_response :success
  end

  test 'create user' do
    request.env['HTTP_REFERER'] = 'back_to_here'
    assert_difference 'User.count', +1 do
      post :create, user: { name: 'name', email: 'email@emailer.com',
                            password: 'password', password_confirmation: 'password' }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
  end

  test 'update user' do
    request.env['HTTP_REFERER'] = 'back_to_here'
    put :update, id: users(:one), user: { name: 'new name' }
    user = assigns(:user)
    assert_equal 'new name', user.name
  end

  test 'password change' do
    request.env['HTTP_REFERER'] = 'back_to_here'
    put :update, id: users(:one), user: { password: 'password1', password_confirmation: 'password1' }
    user = assigns(:user)
    assert_equal 'password1', user.password
  end

  test 'delete user' do
    request.env['HTTP_REFERER'] = 'back_to_here'
    assert_difference 'User.count', -1 do
      delete :destroy, id: users(:one)
    end
  end

end

require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    @user = login_user
  end

  test 'should get edit' do
    get :edit, id: @user.id
    assert_response :success
  end

  test 'user can edit' do
    name = 'FooBar' ; email = 'foo@bar.com'
    put :update, user: { name: name, email: email,
                         password: "", password_confirmation: "" }
    assert @user.name  == name
    assert @user.email == email
  end


end

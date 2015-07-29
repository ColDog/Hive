require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test 'should get edit' do
    user = login_user
    get :edit, id: user.id
    assert_response :success
  end

  test 'user can edit' do
    user = login_user
    name = 'FooBar' ; email = 'foo@bar.com'
    put :update, id: user.id, user: { name: name, email: email, password: '', password_confirmation: '' }
    euser = assigns(:user)
    flsh = { 'success' => 'Account updated.' }
    assert_equal flsh, flash.to_hash
    assert_equal name,  euser.name
    assert_equal email, euser.email
  end

  test 'user signup' do
    user = users(:one)
    digest = SecureRandom.urlsafe_base64
    user.update(signup_digest: digest)
    get :signup, hash: digest, id: user.id
    assert_redirected_to edit_user_path(user)
  end

end

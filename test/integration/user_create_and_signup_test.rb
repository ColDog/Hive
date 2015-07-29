require 'test_helper'

class UserCreateAndSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end


  test 'signup flow' do
    login_admin
    assert_difference User.count, +1 do
      post admin_users_path, user: { name: 'person', email: 'person@email.com',
                                     password: 'password', password_confirmation: 'password' }
    end
    user = assigns(:user)
    assert_equal 1, ActionMailer::Base.deliveries.size
    get signup_path(user.signup_digest, user.id)
    assert_redirected_to user_edit_path(user)
  end

end

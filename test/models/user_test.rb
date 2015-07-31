require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # name
  # email
  # phone
  # account_type
  # inactive_on
  # current
  # password_digest
  # tags
  # notes
  # signup_digest

  setup do
    @user = users(:two)
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'current with date' do
    @user.current = true
    @user.inactive_on = Date.today
    assert_not @user.valid?
  end

  test 'not current without date' do
    @user.current = false
    @user.inactive_on = nil
    assert_not @user.valid?
  end


end

require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  # user_id
  test 'admin must be a user' do
    admin = Admin.new(user_id: nil)
    assert_not admin.valid?
  end

  test 'valid admin signup' do
    admin = Admin.new(user_id: users(:one).id)
    assert admin.valid?, admin.errors.full_messages
  end

end

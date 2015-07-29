ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers

  def login_admin
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in :user, users(:admin)
    users(:admin)
  end

  def login_user
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in :user, users(:one)
    users(:one)
  end

end

class ActionDispatch::IntegrationTest
  include Devise::TestHelpers

  def login_admin
    sign_in :user, users(:admin)
    users(:admin)
  end

  def login_user
    sign_in :user, users(:one)
    users(:one)
  end
end
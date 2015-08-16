ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'codeclimate-test-reporter'
Minitest::Reporters.use!
CodeClimate::TestReporter.start

class ActiveSupport::TestCase
  fixtures :all

  def sample_file(filename = 'hive.pdf')
    File.new("test/fixtures/#{filename}")
  end

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

  def login_user_two
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in :user, users(:two)
    users(:two)
  end

end

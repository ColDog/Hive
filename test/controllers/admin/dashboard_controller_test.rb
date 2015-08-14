require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_REFERER'] = 'back'
    login_admin
  end

  test 'get dashboard' do
    get :index
    assert_response :success
  end

end

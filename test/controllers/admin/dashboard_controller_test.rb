require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase

  setup { login_admin }

  test 'get dashboard' do
    get :index
    assert_response :success
  end

end

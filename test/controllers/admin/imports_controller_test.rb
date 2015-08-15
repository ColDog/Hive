require 'test_helper'

class Admin::ImportsControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_REFERER'] = 'back'
    login_admin
  end

  test 'get index' do
    get :index
    assert_response :success
  end

  test 'csv user upload' do
    file = fixture_file_upload 'user_test.csv'
    assert_difference 'User.count', +2 do
      post :users, user: { file: file, key: SecureRandom.hex }
    end
  end

  test 'csv organization upload' do
    file = fixture_file_upload 'user_test.csv'
    assert_difference 'User.count', 0 do
      post :organizations, organization: { file: file, key: SecureRandom.hex }
    end
  end

  test 'csv supply_list upload' do
    file = fixture_file_upload 'user_test.csv'
    assert_difference 'SupplyList.count', 1 do
      post :supply_lists, supply_list: { supply_id: 1, file: file, key: SecureRandom.hex }
    end
  end

end

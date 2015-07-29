require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should find a post' do
    get :index
    assert_select 'h3', 'MyString'
  end

end

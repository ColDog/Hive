require 'test_helper'

class Admin::HomeContentsControllerTest < ActionController::TestCase

  setup { login_admin }

  test 'get home contents editor' do
    get :index
    assert_response :success
  end

  test 'create post' do
    assert_difference 'HomeContent.count', +1 do
      post :create, home_content: { title: 'hello', content: 'there' }
    end
    assert_response :redirect
  end

  test 'update post' do
    post = home_contents(:one)
    put :update, id: post.id, home_content: { title: 'hello', content: 'hi' }
    assert_response :redirect
    flsh = { 'success' => 'Post updated.' }
    assert_equal flash.to_hash, flsh
  end

  test 'delete post' do
    assert_difference 'HomeContent.count', -1 do
      delete :destroy, id: home_contents(:one).id
    end
  end

end

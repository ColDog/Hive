require 'test_helper'

class SecurityTest < ActionDispatch::IntegrationTest

  gets = %w[
      /admin /admin/home_contents /admin/organizations /admin/users /admin/supplies
      /admin/admins /admin/imports /admin/users/1/edit /admin/supplies/new
  ]
  gets.each do |url|
    test "visit #{url}" do
      get url
      assert_response :redirect
      assert_equal 'You do not have the necessary permissions.', flash[:danger]
    end
  end

  posts = %w[
    /admin/home_contents /admin/organizations /admin/users /admin/supplies
    /admin/supply_lists /admin/imports/users /admin/imports/organizations
  ]
  posts.each do |url|
    test "post #{url}" do
      post url
      assert_response :redirect
      assert_equal 'You do not have the necessary permissions.', flash[:danger]
    end
  end

  puts = %w[
    /admin/home_contents/1 /admin/organizations/1 /admin/users/1 /admin/supplies/1
  ]
  puts.each do |url|
    test "puts #{url}" do
      put url
      assert_response :redirect
      assert_equal 'You do not have the necessary permissions.', flash[:danger]
    end
  end

  nonexistent = %w[
    /nonexistent/route /admin/organizations/1 /admin/users/1 /admin/supplies/1
    /admin/supply_lists/1 /admin/home_contents/1 /admin/attachments/1
  ]
  nonexistent.each do |url|
    test "visit #{url}" do
      get url
      assert_redirected_to root_url
    end
  end

end

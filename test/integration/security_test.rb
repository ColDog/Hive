require 'test_helper'

class SecurityTest < ActionDispatch::IntegrationTest

  urls = %w(
      /admin /admin/home_contents /admin/organizations /admin/users /admin/supplies
      /admin/admins /admin/imports /admin/users/1/edit /admin/supplies/new
  )
  urls.each do |url|
    test "visit #{url}" do
      get url
      assert_response :redirect
      assert_equal 'You do not have the necessary permissions.', flash[:danger]
    end
  end

end

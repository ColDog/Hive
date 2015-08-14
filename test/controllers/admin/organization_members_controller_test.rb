require 'test_helper'

class Admin::OrganizationMembersControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_REFERER'] = 'back'
    login_admin
  end

  test 'create member' do
    request.env['HTTP_REFERER'] = 'back_to_here'
    assert_difference 'OrganizationMember.count', +1 do
      post :create, organization_member: { user_id: 2, organization_id: 1 }
    end
  end

  test 'destroy member' do
    request.env['HTTP_REFERER'] = 'back_to_here'
    assert_difference 'OrganizationMember.count', -1 do
      delete :destroy, id: organization_members(:one).id
    end
  end

end

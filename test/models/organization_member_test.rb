require 'test_helper'

class OrganizationMemberTest < ActiveSupport::TestCase
  # user_id
  # organization_id
  # admin_contact
  # account_contact

  setup do
    @user = users(:two)
    @org = organizations(:two)
  end

  test 'create a valid org member' do
    mem = OrganizationMember.new(user_id: @user.id, organization_id: @org.id)
    assert mem.valid?
  end

  test 'missing user id' do
    mem = OrganizationMember.new(user_id: nil, organization_id: @org.id)
    assert_not mem.valid?
  end

  test 'missing org id' do
    mem = OrganizationMember.new(user_id: @user.id, organization_id: nil)
    assert_not mem.valid?
  end

end

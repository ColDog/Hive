require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # name
  # description
  # avatar
  # signed_service_agreement
  # current
  # inactive_on
  # address
  # city
  # province
  # postal
  # tags

  setup do
    @org = organizations(:one)
  end

  test 'valid organization' do
    assert @org.valid?, @org.errors.full_messages
  end

  test 'no name' do
    @org.name = ''
    assert_not @org.valid?, @org.errors.full_messages
  end

  test 'current with date' do
    @org.current = true
    @org.inactive_on = Date.today
    assert_not @org.valid?
  end

  test 'not current without date' do
    @org.current = false
    @org.inactive_on = nil
    assert_not @org.valid?
  end

end

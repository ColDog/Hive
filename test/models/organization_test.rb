require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # name
  # description
  # avatar
  # service_agreement
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

  test 'signed without service' do
    @org.signed_service_agreement = true
    @org.service_agreement = nil
    assert_not @org.valid?
  end

  # todo having problems easily setting a carrierwave file
  # test 'service without signed' do
  #   @org.signed_service_agreement = false
  #   assert_not @org.valid?, "service agreement present: #{@org.service_agreement.present?} --- signed service agreement: #{@org.signed_service_agreement}"
  # end

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

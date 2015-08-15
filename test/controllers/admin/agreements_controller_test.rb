require 'test_helper'

class Admin::AgreementsControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_REFERER'] = 'back'
    login_admin
  end

  test 'create agreement' do
    file = fixture_file_upload 'hive.pdf'
    assert_difference 'Agreement.count', +1 do
      post :create, organization_id: 1, agreement: { agreement: file, valid_until: Time.now, name: 'new file' }
    end
    assert_response :redirect
  end


  test 'another failed agreement' do
    assert_no_difference 'Agreement.count' do
      post :create,  organization_id: 1, agreement: { valid_until: Time.now, name: 'new file' }
    end
    assert_response :redirect
  end

  test 'failed create agreement' do
    file = fixture_file_upload 'hive.pdf'
    assert_no_difference 'Agreement.count' do
      post :create,  organization_id: 1, agreement: { agreement: file }
    end
    assert_response :redirect
  end

  test 'delete agreement' do
    assert_difference 'Agreement.count', -1 do
      delete :destroy,  organization_id: 1, id: agreements(:one).id
    end
  end

end

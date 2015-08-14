require 'test_helper'

class Admin::AttachmentsControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_REFERER'] = 'back'
    login_admin
  end

  test 'create attachment' do
    file = fixture_file_upload 'hive.pdf'
    assert_difference 'Attachment.count' do
      post :create, attachment: { file: file, name: 'new file' }
    end
    assert_response :redirect
  end

  test 'failed create attachment' do
    file = fixture_file_upload 'hive.pdf'
    assert_no_difference 'Agreement.count' do
      post :create, attachment: { file: file }
    end
    assert_response :redirect
  end

  test 'delete attachment' do
    assert_difference 'Attachment.count', -1 do
      delete :destroy, id: attachments(:one).id
    end
  end

end

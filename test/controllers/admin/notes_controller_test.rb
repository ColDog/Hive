require 'test_helper'

class Admin::NotesControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_REFERER'] = 'back'
    login_admin
  end

  test 'create note' do
    assert_difference 'Note.count', +1 do
      post :create, note: { title: 'Hello', content: 'Foobar' }
    end
  end

  test 'delete note' do
    assert_difference 'Note.count', -1 do
      delete :destroy, id: notes(:one).id
    end
  end

end

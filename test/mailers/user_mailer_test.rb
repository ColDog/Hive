require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test 'content only' do
    pars = {
      'content' => 'hello there person!', 'sign_in_link' => '0', 'subject' => 'A users subject',
      'supplies' => '0', 'account_type' => '0', 'attachments' => []
    }

    user = users(:one)
    tok = 'p34zeA5xA7OsANGV8KDrKA'
    mail = UserMailer.new_user( user, tok,  pars )

    assert_equal 'A users subject',           mail.subject
    assert_equal ['cjwalker@sfu.ca'],         mail.to
    assert_equal ['info@hivevancouver.com'],  mail.from

    matches = [
      'mailto:info@hivevancouver.com', '<p>hello there person!</p>',  'Hello Colin Walker,'
    ]
    matches.each do |match|
      assert_match match, mail.body.encoded
    end

    no_matches = [
      '<a href="/attachments/files">files</a>', '<h5>Your account type: string</h5>',
      'http://localhost:3000/signup/p34zeA5xA7OsANGV8KDrKA/1', '<h5>Your Supply Items:</h5>'
    ]
    no_matches.each do |match|
      assert_no_match match, mail.body.encoded
    end
  end

  test 'everything' do
    pars = {
      'content' => 'hello there person!', 'sign_in_link' => '1', 'subject' => 'New Account Created at Hive',
      'supplies' => '1', 'account_type' => '1', 'attachments' => [1,2]
    }

    user = users(:one)
    tok = 'p34zeA5xA7OsANGV8KDrKA'
    mail = UserMailer.new_user( user, tok,  pars )

    assert_equal 'New Account Created at Hive', mail.subject
    assert_equal ['cjwalker@sfu.ca'],           mail.to
    assert_equal ['info@hivevancouver.com'],    mail.from

    matches = [
      'mailto:info@hivevancouver.com', '<p>hello there person!</p>', '<a href="/attachments/files">files</a>',
      'http://localhost:3000/signup/p34zeA5xA7OsANGV8KDrKA/1', '<h5>Your Supply Items:</h5>',
      '<h5>Your account type: string</h5>', 'Hello Colin Walker,'
    ]
    matches.each do |match|
      assert_match match, mail.body.encoded
    end

  end

end

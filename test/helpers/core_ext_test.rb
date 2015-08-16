require 'test_helper'

class CoreExtTest < ActionView::TestCase

  test 'to_html' do
    assert_equal "<p>hello there jim</p>\n", 'hello there jim'.to_html
  end

  test 'to_table' do
    hsh = [{foo: 'inside', bar: 'inside'}]
    htm = "<table class=\"table\"><thead><tr><th>foo</th><th>bar</th></thead></tr><tr><td>inside</td><td>inside</td></tr></table>"
    assert_equal htm, hsh.to_table
  end

  test 'create cache key' do
    key = Organization.cache_key({id: 1, action: 'action', controller: 'admin/organizations'})
    assert !key.nil?
  end

end
require "test_helper"

class ShortcutsTest < Test::Unit::TestCase
  def setup
    App.destroy_all
    App.load_all
  end

  def test_recognize_root_path
    get "/"
    assert last_response.ok?
  end

  def test_recognize_app_path
    get "/textmate"
    assert last_response.ok?
  end

  def test_redirect_if_no_app_is_found
    get "/invalid"
    assert last_response.redirect?

    follow_redirect!
    assert_equal "http://example.org/", last_request.url
  end

  def test_render_only_the_specified_app
    get "/textmate"
    assert_have_selector "section.shortcuts", :count => 1
    assert_have_selector "section.shortcuts h2", :count => 1
    assert_contain "TextMate"
  end
end

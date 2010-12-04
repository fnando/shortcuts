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

  def test_recognize_api_path
    get "/api"
    assert last_response.ok?
  end

  def test_recognize_app_path
    get "/textmate"
    assert last_response.ok?
  end

  def test_recognize_json_app_path
    get "/textmate.json"
    assert last_response.ok?
  end

  def test_recognize_json_apps_path
    get "/apps.json"
    assert last_response.ok?
  end

  def test_render_json_for_specified_app
    get "/textmate.json"
    data = JSON.load(last_response.body)

    @app = App.find_by_permalink("textmate")

    assert_equal @app.name, data["app"]["name"]
    assert_equal @app.shortcuts.count, data["shortcuts"].count
  end

  def test_render_json_for_all_apps
    get "/apps.json"
    data = JSON.load(last_response.body)

    assert App.count > 0
    assert_equal App.count, data["apps"].count
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

  def test_render_api_page
    get "/api"
    assert_contain "http://shortcutsapp.info/apps.json"
    assert_contain "http://shortcutsapp.info/apps/:app_name.json"
  end
end

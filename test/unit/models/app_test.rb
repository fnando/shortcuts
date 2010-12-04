require "test_helper"

class AppTest < Test::Unit::TestCase
  def setup
    App.destroy_all

    @file = File.dirname(__FILE__) + "/../../resources/app.yml"
    @app = App.load_file(@file)
  end

  def test_return_app_that_was_created_while_importing_file
    assert_kind_of App, @app
    assert !@app.new_record?
  end

  def test_import_app_with_specified_attributes
    assert_equal "Some app", @app.name
    assert_equal "Some nice app. Period.", @app.description
    assert_equal "some-app", @app.permalink
  end

  def test_create_all_shortcuts
    assert_equal 2, @app.shortcuts.count
  end

  def test_create_shortcuts_respecting_the_defined_order
    @shortcut = @app.shortcuts[0]
    assert_equal "Go forward", @shortcut.description
    assert_equal "cmd + right", @shortcut.shortcut

    @shortcut = @app.shortcuts[1]
    assert_equal "Go backward", @shortcut.description
    assert_equal "cmd + left", @shortcut.shortcut
  end

  def test_import_all_files
    App.destroy_all
    App.load_all

    assert_equal 5, App.count
  end
end

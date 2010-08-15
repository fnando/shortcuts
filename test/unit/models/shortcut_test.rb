require "test_helper"

class ShortcutTest < Test::Unit::TestCase
  def test_return_kbd_tag_with_custom_replacement
    @shortcut = Shortcut.new
    assert_equal "<kbd>&#x2318;</kbd> ", @shortcut.kbd_tag("cmd")
  end

  def test_return_kbd_tag_with_no_custom_replacement
    @shortcut = Shortcut.new
    assert_equal "<kbd>lorem</kbd> ", @shortcut.kbd_tag("lorem")
  end

  def test_return_html_representation
    @shortcut = Shortcut.new(:shortcut => "cmd + shift + N")
    assert_equal "<kbd>&#x2318;</kbd> <kbd>&#x21E7;</kbd> <kbd>N</kbd> ", @shortcut.to_html
  end

  def test_return_html_representation_for_shortcuts_with_plus_sign
    @shortcut = Shortcut.new(:shortcut => "cmd + plus")
    assert_equal "<kbd>&#x2318;</kbd> <kbd>+</kbd> ", @shortcut.to_html
  end
end

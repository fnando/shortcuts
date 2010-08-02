class Shortcut < ActiveRecord::Base
  belongs_to :app, :counter_cache => true

  KEYS = {
    :cmd    => "&#x2318;",
    :ctrl   => "&#x2303;",
    :delete => "&#x2326;",
    :down   => "&#x2193;",
    :return => "&#x21A9;",
    :esc    => "&#x238B;",
    :left   => "&#x2190;",
    :option => "&#x2325;",
    :right  => "&#x2192;",
    :shift  => "&#x21E7;",
    :tab    => "&#x21E5;",
    :up     => "&#x2191;"
  }

  MODIFIERS = %w[shift ctrl option cmd delete return up down left right esc tab]

  def to_html
    String.new.tap do |html|
      keys = shortcut.split("+").collect(&:squish)
      keys.each {|key| html << kbd_tag(key) if MODIFIERS.include?(key)}
      (keys - MODIFIERS).each {|key| html << kbd_tag(key)}
    end
  end

  def kbd_tag(key)
    text = KEYS[key.to_sym] || key
    %[<kbd>#{text}</kbd> ]
  end
end

class Shortcut
  include MongoMapper::Document

  key :app_id, ObjectId
  key :shortcut, String
  key :description, String
  timestamps!

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
    :up     => "&#x2191;",
    :plus   => "+",
    :minus  => "-"
  }

  def to_html
    String.new.tap do |html|
      keys = shortcut.split("+").collect {|s| s.gsub(/^ *(.*?) ?$/, '\1') }
      keys.each {|key| html << kbd_tag(key)}
    end
  end

  def kbd_tag(key)
    text = KEYS[key.to_sym] || key
    %[<kbd>#{text}</kbd> ]
  end
end

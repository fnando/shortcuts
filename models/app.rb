class App < ActiveRecord::Base
  has_many :shortcuts, :dependent => :destroy

  scope :sorted, order("name asc")

  def self.load_all
    Dir[File.dirname(__FILE__) + "/../shortcuts/*.yml"].each do |file|
      load(file)
    end
  end

  def self.load(file)
    info = HashWithIndifferentAccess.new(YAML.load_file(file))

    # Find app or create it. Then update its attributes.
    app = find_or_create_by_permalink(info[:permalink])
    app.update_attributes :name => info[:name], :description => info[:description]

    # Remove all shortcuts. Then add them once again.
    app.shortcuts.destroy_all

    info[:shortcuts].each do |shortcut, description|
      app.shortcuts.create(:shortcut => shortcut, :description => description)
    end
  end
end

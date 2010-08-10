class App
  include MongoMapper::Document

  many :shortcuts
  key :permalink, String
  key :name, String
  key :description, String
  timestamps!

  def self.load_all
    Dir[File.dirname(__FILE__) + "/../shortcuts/**/*.yml"].each do |file|
      self.load_file(File.expand_path(file))
    end
  end

  def self.load_file(file)
    info = YAML.load_file(file)
    attrs = {
      :name => info["name"],
      :description => info["description"]
    }

    # Find app or create it. Then update its attributes.
    app = find_or_create_by_permalink(info["permalink"])
    app.update_attributes(attrs)

    # Remove all shortcuts. Then add them once again.
    app.shortcuts.destroy_all

    info["shortcuts"].each do |shortcut, description|
      app.shortcuts.create(:shortcut => shortcut, :description => description)
    end

    # Return app
    app
  end
end

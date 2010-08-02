class CreateShortcuts < ActiveRecord::Migration
  def self.up
    create_table :shortcuts do |t|
      t.string :shortcut, :description
      t.references :app
      t.timestamps
    end

    add_index :shortcuts, :app_id
  end
end

class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :name, :description, :permalink
      t.integer :shortcuts_count, :default => 0, :null => false
      t.timestamps
    end

    add_index :apps, :permalink, :unique => true
  end
end

class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :lifecycle

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end

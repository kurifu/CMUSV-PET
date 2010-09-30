class DropColumnLifecycleFromProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :lifecycle
  end

  def self.down
    add_column :projects, :lifecycle
  end
end

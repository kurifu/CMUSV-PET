class AddColumnLifecycleIdToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :lifecycle_id, :integer,
                          :null => false,
                          :default => -1

  end

  def self.down
  end
end

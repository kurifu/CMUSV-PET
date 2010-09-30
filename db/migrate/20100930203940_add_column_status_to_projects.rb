class AddColumnStatusToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :status, :string,
                          :null => false,
                          :default => "Unknown"
  end

  def self.down
    remove_column :projects, :status
  end
end

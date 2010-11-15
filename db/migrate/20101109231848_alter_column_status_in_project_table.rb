class AlterColumnStatusInProjectTable < ActiveRecord::Migration
  def self.up
    change_column :projects, :status, :string, 
      :null => false,
      :default => "active"
  end

  def self.down
    change_column :projects, :status, :string, 
      :null => false,
      :default => "Unknown"
  end
end

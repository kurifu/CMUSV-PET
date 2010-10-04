class ModifyProjectTable < ActiveRecord::Migration
  def self.up
    add_column :projects, :lifecycle, :string
    remove_column :projects, :lifecycle_id
  end

  def self.down
    add_column :projects, :lifecycle_id, :integer
    remove_column :projects, :lifecycle
  end
end

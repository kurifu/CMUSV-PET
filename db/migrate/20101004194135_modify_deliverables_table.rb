class ModifyDeliverablesTable < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :deliverable_type, :string
    add_column :deliverables, :phase, :string
    remove_column :deliverables, :deliverable_type_id

  end

  def self.down
    remove_column :deliverables, :deliverable_type
    remove_column :deliverables, :phase
    add_column :deliverables, :deliverable_type_id, :integer, :null=>false, :default=>-1
  end
end

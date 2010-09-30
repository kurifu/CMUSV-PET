class ChangeDeliverableNameToName < ActiveRecord::Migration
  def self.up
    rename_column :deliverables, :deliverable_name, :name
  end

  def self.down
    rename_column :deliverables, :name, :deliverable_name
  end
end

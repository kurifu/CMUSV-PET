class ChangeConstraintForDeliverableUrl < ActiveRecord::Migration
  def self.up
    change_column :deliverables, :deliverable_url, :string, :null => true

  end

  def self.down
    change_column :deliverables, :deliverable_url, :string, :null => false
  end
end

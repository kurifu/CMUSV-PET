class AddDescriptionToDeliverable < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :description, :text
  end

  def self.down
    remove_column :deliverables, :description
  end
end

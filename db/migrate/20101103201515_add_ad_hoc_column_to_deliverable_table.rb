class AddAdHocColumnToDeliverableTable < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :ad_hoc, :boolean
  end

  def self.down
    remove_column :deliverables, :ad_hoc
  end
end

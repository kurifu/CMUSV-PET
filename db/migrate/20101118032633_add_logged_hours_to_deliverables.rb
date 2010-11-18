class AddLoggedHoursToDeliverables < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :hours_logged, :float
  end

  def self.down
    remove_column :deliverables, :hours_logged
  end
end

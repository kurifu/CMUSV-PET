class AddDefaultValueToLoggedHoursForDeliverables < ActiveRecord::Migration
  def self.up
    change_column :deliverables, :hours_logged, :float,
      :default => 0.0
  end

  def self.down
    change_column :deliverables, :hours_logged, :float
  end
end

class AddFloatColumnsToDeliverables < ActiveRecord::Migration
  def self.up
    add_column :deliverables, :estimated_size, :float
    add_column :deliverables, :estimated_effort, :float
    add_column :deliverables, :production_rate, :float  
  end

  def self.down
    remove_column :deliverables, :estimated_size
    remove_column :deliverables, :estimated_effort
    remove_column :deliverables, :production_rate
  end
end

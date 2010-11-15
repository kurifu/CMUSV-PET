class ChangeDeliverableColumnsToFloat < ActiveRecord::Migration
  def self.up
    change_column :deliverables, :estimated_effort, :float
    change_column :deliverables, :estimated_size, :float
    change_column :deliverables, :production_rate, :float
  end

  def self.down
    change_column :deliverables, :estimated_effort, :string
    change_column :deliverables, :estimated_size, :string
    change_column :deliverables, :production_rate, :string
  end
end

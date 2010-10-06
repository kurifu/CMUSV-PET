class ChangeColumnTypesToStringInDeliverables < ActiveRecord::Migration
  def self.up
    change_column :deliverables, :estimated_size, :string
    change_column :deliverables, :estimated_effort, :string
    change_column :deliverables, :production_rate, :string
  end

  def self.down
    change_column :deliverables, :estimated_size, :double
    change_column :deliverables, :estimated_effort, :double
    change_column :deliverables, :production_rate, :double
  end
end

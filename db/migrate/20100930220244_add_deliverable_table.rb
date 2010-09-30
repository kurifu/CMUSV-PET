class AddDeliverableTable < ActiveRecord::Migration
  def self.up
    create_table :deliverables do |t|
      t.integer :deliverable_type_id, :null=>false, :default=>-1
      t.integer :project_id, :default=>-1, :null=>false
      t.string :deliverable_name, :null=>false, :default=>""
      t.string :deliverable_url, :null=>false, :default=>""
      t.string :complexity, :null=>false, :default=>""
      t.string :unit_measurement, :null=>false, :default=>""
      t.timestamp
    end
    
  end

  def self.down
    drop_table :deliverables
  end
end

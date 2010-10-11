class DropLifecycleTable < ActiveRecord::Migration
  def self.up
    drop_table :lifecycles
  end

  def self.down
    create_table :lifecycles do |t|
      t.string :name, :null => false
    end
  end
end

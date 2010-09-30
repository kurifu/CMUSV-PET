class CreateTableLifecycle < ActiveRecord::Migration
  def self.up
    create_table :lifecycles do |t|
      t.string :name, :null => false
    end
  end

  def self.down
    drop_table :lifecycles
  end
end

class CreateTemps < ActiveRecord::Migration
  def self.up
    create_table :temps do |t|
      t.string :email
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end

  def self.down
    drop_table :temps
  end
end

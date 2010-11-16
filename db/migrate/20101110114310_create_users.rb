class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.integer :user_id
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :user_class

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

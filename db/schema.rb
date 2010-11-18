# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101118033228) do

  create_table "deliverables", :force => true do |t|
    t.integer "project_id",                      :default => -1,  :null => false
    t.string  "name",                            :default => "",  :null => false
    t.string  "deliverable_url",                 :default => ""
    t.string  "complexity",                      :default => "",  :null => false
    t.string  "unit_measurement",                :default => "",  :null => false
    t.float   "estimated_size",   :limit => 255
    t.float   "estimated_effort", :limit => 255
    t.float   "production_rate",  :limit => 255
    t.string  "deliverable_type"
    t.string  "phase"
    t.text    "description"
    t.boolean "ad_hoc"
    t.float   "hours_logged",                    :default => 0.0
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",      :default => "active", :null => false
    t.string   "lifecycle"
    t.integer  "user_id"
  end

  create_table "temps", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "user_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

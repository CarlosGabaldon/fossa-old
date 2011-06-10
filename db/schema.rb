# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110531023152) do

  create_table "features", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "priority_id"
    t.integer  "project_id"
    t.boolean  "completed",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iterations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "days"
    t.integer  "feature_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "priorities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "priority_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "priority_id"
    t.integer  "feature_id"
    t.integer  "iteration_id"
    t.integer  "user_id"
    t.integer  "days"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

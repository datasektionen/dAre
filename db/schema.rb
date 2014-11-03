# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20141102203311) do

  create_table "administrators", :force => true do |t|
    t.string   "kth_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lodges", :force => true do |t|
    t.string   "address"
    t.integer  "max_accommodates"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "posts", :force => true do |t|
    t.string   "headline"
    t.string   "content"
    t.integer  "administrator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["administrator_id", "created_at"], :name => "index_posts_on_administrator_id_and_created_at"

  create_table "projects", :force => true do |t|
    t.integer  "year"
    t.integer  "spots"
    t.string   "email"
    t.integer  "totalCost"
    t.integer  "registrationCost"
    t.date     "lastPaymentDate"
    t.boolean  "openRegistration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["year"], :name => "index_projects_on_year", :unique => true

  create_table "projects_staffs", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "staff_id"
  end

  create_table "registrations", :force => true do |t|
    t.string   "kth_id"
    t.string   "firstname"
    t.string   "surname"
    t.string   "email"
    t.string   "mobilephone"
    t.string   "address"
    t.string   "postalCode"
    t.string   "postArea"
    t.string   "grade"
    t.string   "allergies"
    t.string   "comment"
    t.boolean  "hasPayedRegistration"
    t.boolean  "hasPayedTotal"
    t.boolean  "partey"
    t.boolean  "reserve"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "lodge_id"
    t.string   "personnummer"
  end

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["name"], :name => "index_settings_on_name", :unique => true

  create_table "staffs", :force => true do |t|
    t.string   "name"
    t.string   "mobilephone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

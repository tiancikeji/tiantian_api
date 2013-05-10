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

ActiveRecord::Schema.define(:version => 20130509062259) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "conversations", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "status"
    t.string   "status_desc"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "trip_id",      :null => false
    t.string   "content"
    t.string   "distance"
    t.integer  "left"
    t.string   "appointment"
    t.string   "end"
    t.string   "start"
    t.integer  "passenger_id"
    t.string   "start_lat",    :null => false
    t.string   "start_lng",    :null => false
    t.string   "end_lat",      :null => false
    t.string   "end_lng",      :null => false
    t.string   "price"
    t.string   "mobile"
  end

  create_table "drivers", :force => true do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "lat"
    t.string   "lng"
    t.string   "password"
    t.string   "car_license"
    t.string   "car_type"
    t.string   "car_service_number"
    t.integer  "rate"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "androidDevice"
    t.string   "iosDevice"
    t.integer  "online",             :default => 0
    t.integer  "status",             :default => 0
  end

  create_table "notifications", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "passengers", :force => true do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "lat"
    t.string   "lng"
    t.string   "password"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "iosDevice"
    t.string   "androidDevice"
    t.integer  "online",        :default => 0
  end

  create_table "trips", :force => true do |t|
    t.string   "start"
    t.string   "end"
    t.string   "appointment"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "passenger_id", :null => false
    t.string   "start_lat",    :null => false
    t.string   "start_lng",    :null => false
    t.string   "end_lat"
    t.string   "end_lng"
    t.string   "price"
  end

end

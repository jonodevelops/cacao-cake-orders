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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160409150658) do

  create_table "cake_sizes", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cake_styles", force: :cascade do |t|
    t.string   "name"
    t.boolean  "current"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "style_photo_file_name"
    t.string   "style_photo_content_type"
    t.integer  "style_photo_file_size"
    t.datetime "style_photo_updated_at"
    t.text     "description"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["order_id"], name: "index_comments_on_order_id"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "customer_name"
    t.string   "customer_phone"
    t.integer  "cake_style_id",                                              null: false
    t.text     "cake_message"
    t.integer  "order_location_id",                                          null: false
    t.date     "order_date"
    t.integer  "pickup_location_id",                                         null: false
    t.date     "pickup_date"
    t.time     "pickup_time",                default: '2000-01-01 14:00:00', null: false
    t.integer  "price"
    t.integer  "deposit"
    t.integer  "balance"
    t.text     "notes"
    t.boolean  "cancelled",                  default: false,                 null: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "message_photo_file_name"
    t.string   "message_photo_content_type"
    t.integer  "message_photo_file_size"
    t.datetime "message_photo_updated_at"
    t.integer  "user_id"
    t.integer  "cake_size_id"
  end

  add_index "orders", ["cake_size_id"], name: "index_orders_on_cake_size_id"
  add_index "orders", ["cake_style_id"], name: "index_orders_on_cake_style_id"
  add_index "orders", ["order_location_id"], name: "index_orders_on_order_location_id"
  add_index "orders", ["pickup_location_id"], name: "index_orders_on_pickup_location_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.integer  "location_id"
  end

  add_index "users", ["location_id"], name: "index_users_on_location_id"

end

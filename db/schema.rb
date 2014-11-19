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

ActiveRecord::Schema.define(version: 20141119202739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dive_sites", force: true do |t|
    t.string   "name",        null: false
    t.string   "location",    null: false
    t.text     "description"
    t.integer  "depth"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "image_likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_likes", ["user_id", "image_id"], name: "index_image_likes_on_user_id_and_image_id", unique: true, using: :btree

  create_table "images", force: true do |t|
    t.integer  "user_id",      null: false
    t.integer  "dive_site_id"
    t.string   "url",          null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "images", ["dive_site_id"], name: "index_images_on_dive_site_id", using: :btree
  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "liked_dive_sites", force: true do |t|
    t.integer  "user_id",      null: false
    t.integer  "dive_site_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "liked_dive_sites", ["user_id", "dive_site_id"], name: "index_liked_dive_sites_on_user_id_and_dive_site_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false, null: false
    t.string   "image_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end

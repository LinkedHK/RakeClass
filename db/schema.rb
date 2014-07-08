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

ActiveRecord::Schema.define(version: 20140707111520) do

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "slap_items", force: true do |t|
    t.string   "item_title"
    t.text     "item_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slap_users", force: true do |t|
    t.string   "username",         limit: 20
    t.string   "email",                       null: false
    t.string   "first_name",       limit: 20
    t.string   "last_name",        limit: 20
    t.string   "password"
    t.string   "language",         limit: 12
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "uid",              limit: 8
    t.string   "provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_index "slap_users", ["created_at", "updated_at"], name: "index_slap_users_on_created_at_and_updated_at", using: :btree
  add_index "slap_users", ["email"], name: "index_user_email", unique: true, using: :btree
  add_index "slap_users", ["oauth_expires_at"], name: "index_slap_users_on_oauth_expires_at", using: :btree
  add_index "slap_users", ["uid"], name: "index_slap_users_on_uid", unique: true, using: :btree
  add_index "slap_users", ["uid"], name: "uid_UNIQUE", unique: true, using: :btree

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_images", force: true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "remote_image"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_image"
  end

  add_index "user_images", ["imageable_id"], name: "index_user_images_on_imageable_id", using: :btree

end

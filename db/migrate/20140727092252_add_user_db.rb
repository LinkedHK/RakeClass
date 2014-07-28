class AddUserDb < ActiveRecord::Migration
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

end

class AddStatuses < ActiveRecord::Migration
  create_table "statuses", force: true do |t|
  t.string   "name"
  t.text     "content"
  t.datetime "created_at"
  t.datetime "updated_at"
  end

end

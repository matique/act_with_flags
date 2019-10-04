ActiveRecord::Schema.define(version: 201910) do

  create_table "orders", force: true do |t|
    t.string   "name"
    t.string   "qty"
    t.integer  "flags"
    t.text     "bigflags"
    t.integer  "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

ActiveRecord::Schema.define(version: 201910) do
  create_table "orders", force: true do |t|
    t.string "name"
    t.string "qty"
    t.integer "flags", default: 0
    t.text "bigflags", default: "0"
    t.integer "category", default: 0
    t.integer "origin1", default: 0
    t.integer "origin2", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end

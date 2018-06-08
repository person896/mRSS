class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table "settings", force: :cascade  do |t|
      t.text     "home_page_content", limit: 65535
      t.datetime "created_at",                      null: false
      t.datetime "updated_at",                      null: false
      t.string   "setting_type"
      t.text     "value",             limit: 65535
    end
  end
end

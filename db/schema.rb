# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_04_055951) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", comment: "イベント", force: :cascade do |t|
    t.string "name", null: false, comment: "イベント名"
    t.integer "mice_type", default: 0, null: false, comment: "MICEのタイプ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", comment: "グループ", force: :cascade do |t|
    t.string "team_name", null: false, comment: "チーム名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "icons", comment: "アイコン", force: :cascade do |t|
    t.text "image_url", null: false, comment: "アイコンのURL"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", comment: "店舗", force: :cascade do |t|
    t.string "name", null: false, comment: "店舗名"
    t.integer "business_type", default: 0, null: false, comment: "業態"
    t.text "description", comment: "店舗の雰囲気など"
    t.text "link_url", comment: "店舗のURL"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suggests", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_suggests_on_group_id"
    t.index ["store_id"], name: "index_suggests_on_store_id"
  end

  create_table "users", comment: "ユーザー", force: :cascade do |t|
    t.bigint "icon_id", null: false, comment: "アイコンID"
    t.bigint "event_id", null: false, comment: "イベントID"
    t.bigint "group_id", comment: "グループID"
    t.string "name1", null: false, comment: "名前1"
    t.string "name2", comment: "名前2"
    t.text "profile", comment: "プロフィール"
    t.string "line_id", null: false, comment: "LINE ID"
    t.datetime "from", comment: "集合可能開始時間"
    t.datetime "to", comment: "集合可能終了時間"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_users_on_event_id"
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["icon_id"], name: "index_users_on_icon_id"
  end

  add_foreign_key "suggests", "groups"
  add_foreign_key "suggests", "stores"
  add_foreign_key "users", "events"
  add_foreign_key "users", "icons"
end

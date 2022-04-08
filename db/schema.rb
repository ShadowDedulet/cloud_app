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

ActiveRecord::Schema.define(version: 2022_04_08_165859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hdds", force: :cascade do |t|
    t.string "hdd_type"
    t.integer "size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "vm_id", null: false
    t.index ["vm_id"], name: "index_hdds_on_vm_id"
  end

  create_table "networks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "networks_orders", id: false, force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "network_id", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.integer "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "options"
    t.bigint "user_id", null: false
    t.index ["cost"], name: "index_orders_on_cost"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "orders_tags", id: false, force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "tag_id", null: false
  end

  create_table "passport_data", force: :cascade do |t|
    t.integer "series"
    t.integer "number"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_passport_data_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects_vms", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "vm_id", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vms", force: :cascade do |t|
    t.string "name"
    t.integer "cpu"
    t.integer "ram"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "hdds", "vms"
  add_foreign_key "orders", "users"
  add_foreign_key "passport_data", "users"
end

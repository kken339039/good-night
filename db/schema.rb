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

ActiveRecord::Schema[7.0].define(version: 2023_06_16_095537) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sleep_records", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "check_in_at"
    t.datetime "check_out_at"
    t.float "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["user_id", "created_at"], name: "index_sleep_records_on_user_id_and_created_at"
    t.index ["user_id", "duration"], name: "index_sleep_records_on_user_id_and_duration"
    t.index ["user_id", "status"], name: "index_sleep_records_on_user_id_and_status"
    t.index ["user_id"], name: "index_sleep_records_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "target_user_id"
    t.datetime "actived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_user_id"], name: "index_subscriptions_on_target_user_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end

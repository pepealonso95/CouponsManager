# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_23_223701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupon_uses", force: :cascade do |t|
    t.integer "coupon_code"
    t.integer "remaining_uses"
    t.datetime "valid_limit"
    t.bigint "promotion_id", null: false
    t.index ["promotion_id"], name: "index_coupon_uses_on_promotion_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "email"
    t.integer "status"
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_invitations_on_organization_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.integer "promotion_type"
    t.integer "return_value", default: 0
    t.boolean "is_percentage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "condition"
    t.integer "total_requests", default: 0
    t.integer "total_response_time", default: 0
    t.integer "positive_response", default: 0
    t.integer "negative_response", default: 0
    t.bigint "organization_id", null: false
    t.integer "total_spent", default: 0
    t.datetime "limit_time"
    t.index ["organization_id"], name: "index_promotions_on_organization_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "promotion_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "transaction_code"
    t.bigint "user_id"
    t.index ["promotion_id"], name: "index_transactions_on_promotion_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "user_coupon_codes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "email"
    t.integer "role", default: 0
    t.string "password"
    t.string "photo_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "organization_id", null: false
    t.string "confirmation_token"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "coupon_uses", "promotions"
  add_foreign_key "invitations", "organizations"
  add_foreign_key "invitations", "users"
  add_foreign_key "promotions", "organizations"
  add_foreign_key "transactions", "promotions"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "organizations"
end

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

ActiveRecord::Schema[8.1].define(version: 2026_03_01_171610) do
  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "identifier"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_accounts_on_identifier", unique: true
  end

  create_table "crono_jobs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "healthy"
    t.string "job_id", null: false
    t.datetime "last_performed_at", precision: nil
    t.text "log", limit: 1073741823
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_crono_jobs_on_job_id", unique: true
  end

  create_table "qbo_accounts", force: :cascade do |t|
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.integer "default_labor"
    t.string "encrypted_access_token"
    t.string "encrypted_access_token_iv"
    t.string "encrypted_companyid"
    t.string "encrypted_companyid_iv"
    t.string "encrypted_refresh_token"
    t.string "encrypted_refresh_token_iv"
    t.datetime "reconnect_token_at"
    t.datetime "token_expires_at"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "users", "accounts"
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180426131109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "ticket_id"
    t.bigint "user_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_comments_on_ticket_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "custom_domain"
    t.string "subdomain", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_domain"], name: "index_companies_on_custom_domain"
    t.index ["subdomain"], name: "index_companies_on_subdomain"
  end

  create_table "company_departments", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "department_id"
    t.index ["company_id", "department_id"], name: "index_company_departments_on_company_id_and_department_id", unique: true
    t.index ["company_id"], name: "index_company_departments_on_company_id"
    t.index ["department_id"], name: "index_company_departments_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_departments_on_name"
  end

  create_table "leave_statuses", force: :cascade do |t|
    t.bigint "leave_id"
    t.string "status"
    t.boolean "active"
    t.integer "changed_by_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leave_id"], name: "index_leave_statuses_on_leave_id"
  end

  create_table "leaves", force: :cascade do |t|
    t.bigint "user_id"
    t.string "leave_type"
    t.text "reason"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leaves_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_roles_on_department_id"
  end

  create_table "ticket_statuses", force: :cascade do |t|
    t.bigint "ticket_user_id"
    t.string "status"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_user_id"], name: "index_ticket_statuses_on_ticket_user_id"
  end

  create_table "ticket_users", force: :cascade do |t|
    t.bigint "ticket_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticket_users_on_ticket_id"
    t.index ["user_id"], name: "index_ticket_users_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "department_id"
    t.integer "role_id"
    t.string "title"
    t.string "description"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.bigint "company_id", null: false
    t.string "contact_number"
    t.string "secondary_contact_number"
    t.string "emergency_contact_person_name"
    t.string "emergency_contact_person_relation"
    t.string "emergency_contact_person_number"
    t.date "dob"
    t.string "permanent_address"
    t.string "temporary_address"
    t.string "bank_account_number"
    t.jsonb "employment_history"
    t.jsonb "performance_evaluation"
    t.integer "reporting_to"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users"
  add_foreign_key "company_departments", "companies"
  add_foreign_key "company_departments", "departments"
  add_foreign_key "leave_statuses", "leaves", column: "leave_id"
  add_foreign_key "leaves", "users"
  add_foreign_key "ticket_statuses", "ticket_users"
  add_foreign_key "ticket_users", "tickets"
  add_foreign_key "ticket_users", "users"
  add_foreign_key "tickets", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end

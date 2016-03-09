# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160309012817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "loans", force: :cascade do |t|
    t.integer  "loan_id"
    t.integer  "member_id"
    t.decimal  "loan_amnt",                   precision: 16, scale: 8
    t.decimal  "funded_amnt",                 precision: 16, scale: 8
    t.decimal  "funded_amnt_inv",             precision: 16, scale: 8
    t.integer  "term"
    t.decimal  "int_rate",                    precision: 16, scale: 8
    t.decimal  "installment",                 precision: 16, scale: 8
    t.string   "grade"
    t.string   "sub_grade"
    t.string   "emp_title"
    t.string   "emp_length"
    t.string   "home_ownership"
    t.decimal  "annual_inc",                  precision: 16, scale: 8
    t.decimal  "verification_status"
    t.datetime "issue_d"
    t.string   "loan_status"
    t.string   "pymnt_plan"
    t.string   "url"
    t.text     "desc"
    t.text     "purpose"
    t.string   "title"
    t.string   "zip_code"
    t.string   "addr_state"
    t.decimal  "dti",                         precision: 16, scale: 8
    t.integer  "delinq_2yrs"
    t.datetime "earliest_cr_line"
    t.integer  "inq_last_6mths"
    t.integer  "mths_since_last_delinq"
    t.integer  "mths_since_last_record"
    t.integer  "open_acc"
    t.integer  "pub_rec"
    t.decimal  "revol_bal",                   precision: 16, scale: 8
    t.decimal  "revol_util",                  precision: 16, scale: 8
    t.decimal  "total_acc",                   precision: 16, scale: 8
    t.string   "initial_list_status"
    t.decimal  "out_prncp",                   precision: 16, scale: 8
    t.decimal  "out_prncp_inv",               precision: 16, scale: 8
    t.decimal  "total_pymnt",                 precision: 16, scale: 8
    t.decimal  "total_pymnt_inv",             precision: 16, scale: 8
    t.decimal  "total_rec_prncp",             precision: 16, scale: 8
    t.decimal  "total_rec_int",               precision: 16, scale: 8
    t.decimal  "total_rec_late_fee",          precision: 16, scale: 8
    t.decimal  "recoveries",                  precision: 16, scale: 8
    t.decimal  "collection_recovery_fee",     precision: 16, scale: 8
    t.datetime "last_pymnt_d"
    t.decimal  "last_pymnt_amnt",             precision: 16, scale: 8
    t.datetime "next_pymnt_d"
    t.datetime "last_credit_pull_d"
    t.integer  "collections_12_mths_ex_med"
    t.integer  "mths_since_last_major_derog"
    t.string   "policy_code"
    t.string   "application_type"
    t.decimal  "annual_inc_joint",            precision: 16, scale: 8
    t.decimal  "dti_joint",                   precision: 16, scale: 8
    t.string   "verification_status_joint"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "fico_mean"
  end

  add_index "loans", ["loan_id"], name: "index_loans_on_loan_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.integer  "loan_id"
    t.integer  "note_id"
    t.integer  "order_id"
    t.decimal  "outstanding_principal",   precision: 16, scale: 8
    t.decimal  "accrued_interest",        precision: 16, scale: 8
    t.string   "status"
    t.decimal  "ask_price",               precision: 16, scale: 8
    t.decimal  "markup_discount",         precision: 16, scale: 8
    t.decimal  "ytm",                     precision: 16, scale: 8
    t.integer  "days_since_last_payment"
    t.string   "credit_score_trend"
    t.decimal  "fico_end_range_mean",     precision: 16, scale: 8
    t.datetime "datetime_listed"
    t.boolean  "never_late"
    t.string   "loan_class"
    t.integer  "loan_maturity"
    t.decimal  "original_note_amount",    precision: 16, scale: 8
    t.decimal  "interest_rate",           precision: 16, scale: 8
    t.integer  "remaining_payments"
    t.decimal  "principal_interest",      precision: 16, scale: 8
    t.string   "application_type"
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "market_status",                                    default: 0
  end

  add_index "notes", ["id", "market_status"], name: "index_notes_on_id_and_market_status", using: :btree
  add_index "notes", ["note_id", "loan_id", "order_id"], name: "index_notes_on_note_id_and_loan_id_and_order_id", using: :btree
  add_index "notes", ["note_id"], name: "index_notes_on_note_id", unique: true, using: :btree

  create_table "old_loans", id: false, force: :cascade do |t|
    t.integer  "loan_id",                                     null: false
    t.integer  "member_id"
    t.float    "loan_amount"
    t.float    "funded_amount"
    t.float    "funded_amount_invested"
    t.integer  "term"
    t.float    "interest_rate"
    t.float    "installment"
    t.string   "grade",                           limit: 255
    t.string   "sub_grade",                       limit: 255
    t.string   "employment_title",                limit: 255
    t.string   "employment_length",               limit: 255
    t.string   "home_ownership",                  limit: 255
    t.float    "annual_income"
    t.integer  "income_is_verfied"
    t.string   "issue_date",                      limit: 255
    t.integer  "loan_status"
    t.string   "payment_plan",                    limit: 255
    t.string   "url",                             limit: 255
    t.text     "description"
    t.string   "purpose",                         limit: 255
    t.string   "title",                           limit: 255
    t.string   "zip_code",                        limit: 255
    t.string   "address_state",                   limit: 255
    t.float    "dti"
    t.integer  "delinquencies2_years"
    t.string   "earliest_credit_line",            limit: 255
    t.integer  "fico_range_low"
    t.integer  "fico_range_high"
    t.integer  "inquiries_last6_months"
    t.integer  "months_since_last_inquiry"
    t.integer  "months_since_last_delinquency"
    t.integer  "months_since_last_record"
    t.integer  "open_accounts"
    t.integer  "public_records"
    t.float    "revolving_balance"
    t.float    "revolving_utilization"
    t.integer  "total_accounts"
    t.integer  "initial_list_status"
    t.float    "outstanding_principal"
    t.float    "outstanding_principal_invested"
    t.float    "total_payment"
    t.float    "total_payment_invested"
    t.float    "total_received_principal"
    t.float    "total_received_interest"
    t.float    "total_received_late_fees"
    t.float    "recoveries"
    t.float    "collection_recovery_fees"
    t.string   "last_payment_date",               limit: 255
    t.float    "last_payment_amount"
    t.string   "next_payment_date",               limit: 255
    t.string   "last_credit_pull_date",           limit: 255
    t.integer  "last_fico_range_high"
    t.integer  "last_fico_range_low"
    t.integer  "collections12_excluding_medical"
    t.integer  "months_since_last_major_derog"
    t.datetime "updated_at",                                  null: false
    t.datetime "created_at",                                  null: false
    t.string   "policy_code",                     limit: 255
  end

  add_index "old_loans", ["loan_id"], name: "index_loans_loan_id", using: :btree
  add_index "old_loans", ["loan_id"], name: "loans_loan_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "strategies", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.json     "search_params"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "deleted_at"
    t.json     "execution_params"
    t.boolean  "active"
  end

  add_index "strategies", ["deleted_at"], name: "index_strategies_on_deleted_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "email",                               default: "", null: false
    t.string   "encrypted_password",                  default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "encrypted_lending_club_investor_id"
    t.string   "encrypted_lending_club_access_token"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end

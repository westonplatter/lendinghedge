class AddNoteTsTable < ActiveRecord::Migration
  def change
    create_table "notes_ts", force: :cascade do |t|
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
  end
end

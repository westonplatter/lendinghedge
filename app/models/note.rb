# == Schema Information
#
# Table name: notes
#
#  id                      :integer          not null, primary key
#  loan_id                 :integer
#  note_id                 :integer
#  order_id                :integer
#  outstanding_principal   :decimal(16, 8)
#  accrued_interest        :decimal(16, 8)
#  status                  :string
#  ask_price               :decimal(16, 8)
#  markup_discount         :decimal(16, 8)
#  ytm                     :decimal(16, 8)
#  days_since_last_payment :integer
#  credit_score_trend      :string
#  fico_end_range_mean     :decimal(16, 8)
#  datetime_listed         :datetime
#  never_late              :boolean
#  loan_class              :string
#  loan_maturity           :integer
#  original_note_amount    :decimal(16, 8)
#  interest_rate           :decimal(16, 8)
#  remaining_payments      :integer
#  principal_interest      :decimal(16, 8)
#  application_type        :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  market_status           :integer          default(0)
#
# Indexes
#
#  index_notes_on_id_and_market_status              (id,market_status)
#  index_notes_on_note_id                           (note_id) UNIQUE
#  index_notes_on_note_id_and_loan_id_and_order_id  (note_id,loan_id,order_id)
#

class Note < ActiveRecord::Base
  # include DataConversions

  enum market_status: { active: 0, archived: 1 }

  belongs_to :loan, primary_key: "loan_id"

  # delegate :dti, :annual_inc, :purpose, :revol_util, to: :loan

  def dti
    loan.try(:dti)
  end

  def annual_inc
    loan.try(:annual_inc)
  end

  def purpose
    loan.try(:purpose)
  end

  def revol_util
    loan.try(:revol_util)
  end

  class << self
    def parse_csv_row(row)
      x = Note.new(
        loan_id: row["LoanId"],
        note_id: row["NoteId"],
        order_id: row["OrderId"],
        outstanding_principal: row["OutstandingPrincipal"],
        accrued_interest: row["AccruedInterest"],
        status: row["Status"],
        ask_price: row["AskPrice"],
        markup_discount: row["Markup/Discount"],
        ytm: row["YTM"],
        days_since_last_payment: row["DaysSinceLastPayment"].to_i,
        credit_score_trend: row["CreditScoreTrend"],
        fico_end_range_mean: compute_fico_mean(row["FICO End Range"]),
        datetime_listed: parse_day_month_year(row["Date/Time Listed"]),
        never_late: to_bool(row["NeverLate"]),
        loan_class: row["Loan Class"],
        loan_maturity: row["Loan Maturity"],
        original_note_amount: row["Original Note Amount"],
        interest_rate: row['Interest Rate'],
        remaining_payments: row["Remaining Payments"],
        principal_interest: row["Principal + Interest"],
        application_type: row["Application Type"]
      )

      return x
    end

    def parse_day_month_year(str)
      return nil if str.nil?
      return nil if str.empty?
      DateTime.strptime(str, '%m/%d/%Y')
    end

    MAPPINGS_HASH = {
      # loan attributes
      "loan_amnt_lteq"        => "amnt_lteq",
      "loan_amnt_gteq"        => "amnt_gteq",
      "loan_term_lteq"        => "term_lteq",
      "loan_term_gteq"        => "term_gteq",
      "loan_int_rate_gteq"    => "int_rate_gteq",
      "loan_int_rate_lteq"    => "int_rate_gteq",
      "loan_pub_rec_lteq"     => "pub_rec_lteq",
      "loan_pub_rec_gteq"     => "pub_rec_gteq",
      "loan_dti_gteq"         => "dti_gteq",
      "loan_dti_lteq"         => "dti_lteq",
      "loan_revol_util_gteq"  => "revol_util_gteq",
      "loan_revol_util_lteq"  => "revol_util_lteq",
      "loan_fico_mean_gteq"   => "fico_mean_gteq",
      "loan_fico_mean_lteq"   => "fico_mean_lteq",
      "loan_annual_inc_gteq"  => "annual_inc_gteq",
      "loan_annual_inc_lteq"  => "annual_inc_lteq",
      "loan_purpose_cont"     => "purpose_cont",
      "loan_purpose_not_cont" => "purpose_not_cont",

      # note attributes
      "outstanding_principal_gteq"      => "outstanding_principal_gteq",
      "outstanding_principal_lteq"      => "outstanding_principal_lteq",
      "accrued_interest_gteq"           => "accrued_interest_gteq",
      "accrued_interest_lteq"           => "accrued_interest_lteq",
      "status_eq"                       => "status_eq",
      "ask_price_gteq"                  => "ask_price_gteq",
      "ask_price_lteq"                  => "ask_price_lteq",
      "markup_discount_lteq"            => "markup_discount_lteq",
      "markup_discount_gteq"            => "markup_discount_gteq",
      "ytm_gteq"                        => "ytm_gteq",
      "ytm_lteq"                        => "ytm_lteq",
      "days_since_last_payment_gteq"    => "days_since_last_payment_gteq",
      "days_since_last_payment_lteq"    => "days_since_last_payment_lteq",
      "credit_score_trendcore_trend_eq" => "credit_score_trend_eq",
      "fico_end_range_mean_gteq"        => "fico_end_range_mean_gteq",
      "fico_end_range_mean_lteq"        => "fico_end_range_mean_lteq",
      "never_late_eq"                   => "never_late_eq",
      "loan_class_cont"                 => "loan_class_cont",
      "loan_maturity_gteq"              => "loan_maturity_gteq",
      "loan_maturity_lteq"              => "loan_maturity_lteq",
      "original_note_amount_lteq"       => "original_note_amount_lteq",
      "original_note_amount_gteq"       => "original_note_amount_gteq",
      "interest_rate_lteq"              => "interest_rate_lteq",
      "interest_rate_gteq"              => "interest_rate_gteq",
      "remaining_payments_gteq"         => "remaining_payments_gteq",
      "remaining_payments_lteq"         => "remaining_payments_lteq",
      "principal_interest_gteq"         => "principal_interest_gteq",
      "principal_interest_lteq"         => "principal_interest_lteq",
      "application_type_eq"             => "application_type_eq",
    }

    def ransack_params_from_strategy(params_hash)
      hash = {}

      MAPPINGS_HASH.each do |k,v|
        hash[k] = params_hash[v] if !params_hash[v].nil?
      end

      return hash
    end

    def tf
      "/Users/weston/lh/lh_fast/spec/support/efolio_sample.csv"
    end

    def to_bool(x)
      return true   if x == true   || x =~ (/(true|t|yes|y|1)$/i)
      return false  if x == false  || x.blank? || x =~ (/(false|f|no|n|0)$/i)
      raise ArgumentError.new("invalid value for Boolean: \"#{x}\"")
    end

    def compute_fico_mean(fico_range)
      l, h = fico_range.split("-").map(&:to_i)
      return l if (h.nil? and l > 0)
      return h if (l.nil? and h > 0)
      return ((h + l)/2)
    end
  end

  #
  # LendingClub gem
  #
  def init_lc_efolio_order
    LendingClub::EfolioOrder.new(
      self.loan_id,
      self.order_id,
      self.note_id,
      self.ask_price
    )
  end
end

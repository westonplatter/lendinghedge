class Note < ActiveRecord::Base

  belongs_to :loan, primary_key: "loan_id"

  def self.parse_csv_row(row)
    x = Note.new \
      loan_id: row["LoanId"],
      note_id: row["NoteId"],
      order_id: row["OrderId"],
      outstanding_principal: row["OutstandingPrincipal"],
      accrued_interest: row["AccruedInterest"],
      status: row["Status"],
      ask_price: row["AskPrice"],
      markup_discount: row["Markup/Discount"],
      ytm: row["YTM"],
      days_since_last_payment: row["DaysSinceLastPayment"],
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

    return x
  end

  def self.compute_fico_mean(fico_range)
    l, h = fico_range.split("-").map(&:to_i)
    return l if (h.nil? and l > 0)
    return h if (l.nil? and h > 0)
    return ((h + l)/2)
  end

  def self.parse_day_month_year(str)
    return nil if str.nil?
    return nil if str.empty?
    DateTime.strptime(str, '%m/%d/%Y')
  end

  def self.to_bool(x)
    return true   if x == true   || x =~ (/(true|t|yes|y|1)$/i)
    return false  if x == false  || x.blank? || x =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{x}\"")
  end

end

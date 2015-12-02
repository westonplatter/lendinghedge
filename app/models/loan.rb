class Loan < ActiveRecord::Base

  def self.parse_csv_row(row)
    l = Loan.new \
      loan_id: row["id"],
      member_id: row["member_id"],
      loan_amnt: row["loan_amnt"],
      funded_amnt: row["funded_amnt"],
      funded_amnt_inv: row["funded_amnt_inv"],
      term: row["term"],
      int_rate: row["int_rate"],
      installment: row["installment"],
      grade: row["grade"],
      sub_grade: row["sub_grade"],
      emp_title: row["emp_title"].nil? ? nil : row["emp_title"].force_encoding("UTF-8"),
      emp_length: row["emp_length"],
      home_ownership: row["home_ownership"],
      annual_inc: row["annual_inc"],
      verification_status: row["verification_status"],
      issue_d: parse_month_year(row["issue_d"]),
      loan_status: row["loan_status"],
      pymnt_plan: row["pymnt_plan"],
      url: row["url"],
      desc: row["desc"].nil?       ? nil : row["desc"].force_encoding("UTF-8"),
      purpose: row["purpose"].nil? ? nil : row["purpose"].force_encoding("UTF-8"),
      title: row["title"].nil?     ? nil : row["title"].force_encoding("UTF-8"),
      zip_code: row["zip_code"],
      addr_state: row["addr_state"],
      dti: row["dti"],
      delinq_2yrs: row["delinq_2yrs"],
      earliest_cr_line: parse_month_year(row["earliest_cr_line"]),
      inq_last_6mths: row["inq_last_6mths"],
      mths_since_last_delinq: row["mths_since_last_delinq"],
      mths_since_last_record: row["mths_since_last_record"],
      open_acc: row["open_acc"],
      pub_rec: row["pub_rec"],
      revol_bal: row["revol_bal"],
      revol_util: row["revol_util"],
      total_acc: row["total_acc"],
      initial_list_status: row["initial_list_status"],
      out_prncp: row["out_prncp"],
      out_prncp_inv: row["out_prncp_inv"],
      total_pymnt: row["total_pymnt"],
      total_pymnt_inv: row["total_pymnt_inv"],
      total_rec_prncp: row["total_rec_prncp"],
      total_rec_int: row["total_rec_int"],
      total_rec_late_fee: row["total_rec_late_fee"],
      recoveries: row["recoveries"],
      collection_recovery_fee: row["collection_recovery_fee"],
      last_pymnt_d: parse_month_year(row["last_pymnt_d"]),
      last_pymnt_amnt: row["last_pymnt_amnt"],
      next_pymnt_d: parse_month_year(row["next_pymnt_d"]),
      last_credit_pull_d: parse_month_year(row["last_pymnt_d"]),
      collections_12_mths_ex_med: row["collections_12_mths_ex_med"],
      mths_since_last_major_derog: row["mths_since_last_major_derog"],
      policy_code: row["policy_code"],
      application_type: row["application_type"],
      annual_inc_joint: row["annual_inc_joint"],
      dti_joint: row["dti_joint"],
      verification_status_joint: row["verification_status_joint"]

    return l
  end

  def self.parse_month_year(str)
    return nil if str.nil?
    return nil if str.empty?
    DateTime.strptime(str, '%b-%Y')
  end

end

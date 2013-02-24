require_relative '../interest'

class Interest::Compound

  attr_accessor :loan, :interest,   :length_months,
                :repayment_ammount, :repayment_interest
  def calc_repayment_ammount
  	# repayment_ammount_error unless repayment_ammount_variables
    @repayment_interest = calc_repayment_interest
  end

  private

  def calc_repayment_interest
    loan * (interest.round(2)/100) * (length_months.round(2)/12)
  end
end
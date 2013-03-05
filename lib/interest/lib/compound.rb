require_relative '../interest'

# annual compound interest = interest is paid/added to the 
# principal once per year
# otherwise converted at other regular periods, number of times
# it's converted p/a = frequency_of_conversion

class Interest::Compound
  class VariableMissingError < StandardError; end

  attr_accessor :principal

  attr_accessor :interest,      :repayment_interest,
                :length_months, :repayment_ammount
  def calc_repayment_ammount
  	repayment_ammount_error unless repayment_ammount_variables
    @repayment_interest = calc_repayment_interest
    @repayment_ammount  = repayment_interest + principal
  end

  attr_accessor :periods, :interest_per_period, :compound_ammount
  def calc_compound_ammount
    accumulated_sum_error unless accumulated_sum_variables
    @compound_ammount = (principal *
      (1 + as_percentage(interest_per_period)) **
      periods).round(2)
  end

  attr_accessor :frequency_of_conversion, :nominal_rate_interest
  def calc_interest_per_period
    interest_per_period_error unless interest_per_period_variables
    @interest_per_period = nominal_rate_interest / frequency_of_conversion
  end

  attr_accessor :periodic_rate_of_interest
  def calc_periodic_rate_of_interest
    periodic_rate_of_interest_error unless periodic_rate_of_interest_variables
    calc_interest_per_period
    @periodic_rate_of_interest = (principal * ((1 + as_percentage(interest_per_period)) ** periods)).round(2)
  end

  private

  def calc_repayment_interest
    principal * as_percentage(interest) * in_years(length_months)
  end

  def as_percentage(variable)
    variable.round(2)/100
  end

  def in_years(months)
    months.round(2)/12
  end

  def repayment_ammount_variables
    principal && interest && length_months
  end

  def accumulated_sum_variables
    principal && periods && interest_per_period
  end

  def interest_per_period_variables
    @frequency_of_conversion && @nominal_rate_interest
  end

  def periodic_rate_of_interest_variables
    @principal && @periods && @frequency_of_conversion && @nominal_rate_interest
  end

  def repayment_ammount_error
    variable_missing_error_raiser(repayment_ammount_variables)
  end

  def accumulated_sum_error
    variable_missing_error_raiser(accumulated_sum_variables)
  end

  def interest_per_period_error
    variable_missing_error_raiser(interest_per_period_variables)
  end

  def periodic_rate_of_interest_error
    variable_missing_error_raiser(periodic_rate_of_interest_variables)
  end

  def variable_missing_error_raiser(variables)
    raise VariableMissingError, "Need all: #{variables}"
  end
end
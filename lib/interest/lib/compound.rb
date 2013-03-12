require_relative '../interest'

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

  attr_accessor :periods,          :interest_per_period,
                :compound_ammount, :interest_ammount
  def calc_compound_ammount
    accumulated_sum_error unless accumulated_sum_variables
    @compound_ammount = (principal *
      (1 + as_percentage(interest_per_period)) ** periods).round(2)
    @interest_ammount = (compound_ammount - principal).round(2)
  end

  attr_accessor :frequency_of_conversion, :nominal_rate_interest
  def calc_interest_per_period
    interest_per_period_error unless interest_per_period_variables
    @interest_per_period = ((nominal_rate_interest).round(2) / frequency_of_conversion).round(2)
  end

  attr_accessor :time_required, :final_ammount
  def calc_time_required
    time_required_error unless time_required_variables
    @time_required = (Math.log(final_ammount) - Math.log(principal)) /
                      (Math.log(1 + as_percentage(interest_per_period)))
    @time_required = @time_required.round(2)
  end

  attr_accessor :periodic_rate
  def calc_periodic_rate
    calc_interest_per_period
    periodic_rate_as_percentage = ((1 + as_percentage(interest_per_period)) ** frequency_of_conversion) - 1
    @periodic_rate = (periodic_rate_as_percentage * 100).round(1)
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
    frequency_of_conversion && nominal_rate_interest
  end

  def time_required_variables
    principal && final_ammount &&
    interest_per_period && frequency_of_conversion
  end

  def repayment_ammount_error
    vars = "principal && interest && length_months"
    variable_missing_error_raiser(vars)
  end

  def accumulated_sum_error
    vars = "principal && periods && interest_per_period"
    variable_missing_error_raiser(vars)
  end

  def interest_per_period_error
    vars = "@frequency_of_conversion && @nominal_rate_interest"
    variable_missing_error_raiser(vars)
  end

  def time_required_error
    vars = "principal && final_ammount && interest_per_period && frequency_of_conversion"
    variable_missing_error_raiser(vars)
  end

  def variable_missing_error_raiser(variables)
    raise VariableMissingError, "Need all: #{variables}"
  end
end
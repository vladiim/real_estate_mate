require_relative '../interest'
require_relative '../../conversions/time_conversions'
require 'date'

# named as in interest bearing loan

# the present value of a debit involves one rate and bears interest
# at another rate

# the present value of the maturity uses the rate of discount
# also known as discount_rate or by expression 'money is worth'

# variables:
# P = principal ($)                   - principal
# r = anuual rate (%)                 - annual_rate
# t = term (years)                    - term
# I = total interest ($)              - total_interest
# S = sum of principal & interest ($) - total_sum

class Interest::Bearing

  class VariableMissingError < StandardError; end

  attr_accessor :principal, :annual_rate, :monetery_value

  attr_accessor :duration,        :commencement_date, :discount_rate,
                :discount_start,  :date_of_maturity,  :total_sum,
                :discount_period, :debt_at_maturity
  def calc_debt_at_maturity
    debt_at_maturity_error unless debt_at_maturity_variables
  	@date_of_maturity = calc_date_of_maturity
  	@total_sum        = calc_total_sum
  	@discount_period  = calc_discount_period
  	@debt_at_maturity = calc_sum_received
  end

  attr_accessor :term_in_days, :customer_proceeds
  def calc_face_value_of_note
    face_value_of_note_error unless face_value_of_note_variables
    (@customer_proceeds / (1 - (annual_rate_as_percentage * term_in_years))).round(2)
  end


  def calc_total_sum
    total_sum_variables_error unless total_sum_variables
    (@principal * (1 + (annual_rate_as_percentage * calc_initial_term)))
  end

  attr_accessor :note, :maturity_time_in_days, :annual_rate_at_maturity,
                :maturity_value, :lender_proceeds_to_lendee, :lender_discount_on_maturity_value
  def calc_discount_on_maturity
    discount_on_maturity_error unless discount_on_maturity_variables
    @maturity_value                    = calc_maturity_value
    @lender_discount_on_maturity_value = calc_lender_discount_on_maturity_value
    @lender_proceeds_to_lendee         = calc_lender_proceeds_to_lendee
  end

  # aka equated date, is the date on which a series of
  # debts may be equitably discharged by a single payment
  # the payment must be equal to the face value of the sum
  # of debts
  def calc_average_due_date
    
  end

  private

  def calc_maturity_value
    @note + (@note * annual_rate_as_percentage * term_in_years)
  end

  def calc_sum_received
    (@total_sum / ( 1 + (discount_rate_as_percentage * calc_discounted_term) )).round(2)
  end

  def calc_lender_discount_on_maturity_value
    (@maturity_value * annual_rate_at_maturity_as_percentage * discount_period_in_years).round(2)
  end

  def calc_lender_proceeds_to_lendee
    @maturity_value - @lender_discount_on_maturity_value
  end

  def calc_date_of_maturity
    # this calculates duration in days
    Date.parse(@commencement_date) + @duration
  end

  def calc_discount_period
    discount_period_vaiables_error unless discount_period_vaiables
    @date_of_maturity - Date.parse(@discount_start)
  end

  def calc_initial_term
    (@duration.round(2) / 365.round(2)).round(2)
  end

  def calc_discounted_term
    (@discount_period.round(2) / 365.round(2)).round(7)
  end

  def total_sum_variables
  	@annual_rate && @duration && @principal
  end

  def discount_period_vaiables
  	@discount_start && @date_of_maturity
  end

  def debt_at_maturity_variables
    @principal && @duration && @commencement_date &&
    @annual_rate && @discount_rate && @discount_start
  end

  def discount_on_maturity_variables
    @term_in_days && @annual_rate && @note &&
    @maturity_time_in_days && @annual_rate_at_maturity
  end

  def face_value_of_note_variables
    @term_in_days && @annual_rate && @customer_proceeds
  end

  def annual_rate_as_percentage
  	TimeConversions.annual_rate_percentage(@annual_rate)
  end

  def annual_rate_at_maturity_as_percentage
    TimeConversions.annual_rate_percentage(@annual_rate_at_maturity)
  end

  def discount_rate_as_percentage
  	TimeConversions.annual_rate_percentage(@discount_rate)
  end

  def term_in_years
    @term ? @term : TimeConversions.term_in_years(@term_in_days)
  end

  def discount_period_in_years
    discount_period = @term_in_days - @maturity_time_in_days
    TimeConversions.term_in_years discount_period
  end

  def debt_at_maturity_error
    raise VariableMissingError, "Need all: @principal && @duration && @commencement_date && @annual_rate && @discount_rate && @discount_start"
  end

  def total_sum_variables_error
    raise VariableMissingError, "Need @annual_rate, @duration and @principal"
  end

  def discount_period_vaiables_error
    raise VariableMissingError, "Need @discount_start && @date_of_maturity"
  end

  def discount_on_maturity_error
    raise VariableMissingError, "Need all: @term_in_days && @annual_rate && @note && @maturity_time_in_days && @annual_rate_at_maturity"
  end

  def face_value_of_note_error
    raise VariableMissingError, 'Need all: @term_in_days && @annual_rate && @customer_proceeds'
  end
end
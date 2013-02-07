require_relative '../interest'
require 'date'

# named as in interest bearing loan

# the present value of a debit involves one rate and bears interest
# at another rate

# the present value of the maturity uses the rate of discount
# also known as discount_rate or by expression 'money is worth'

# process to solving interest-beaing debt problems:
# 1. determine the date of maturity of the note
# 2. compute the value of the debt @ maturity
# 3. determine the discount period
# 4. compute the proceeds (sum received)

# variables:
# P = principal ($)                   - principal
# r = anuual rate (%)                 - annual_rate
# t = term (years)                    - term
# I = total interest ($)              - total_interest
# S = sum of principal & interest ($) - total_sum

# calculations:
# S = P(1 + rt)

class Interest::Bearing

  class NeedTotalSumError  < StandardError; end
  class NeedDiscountPeriod < StandardError; end

  attr_accessor :duration,       :commencement_date, :total_sum,
                :annual_rate,    :date_of_maturity,  :discount_start,
                :monetery_value, :principal,         :discount_end,
                :discount_rate,  :discount_period,   :debt_at_maturity

  def calc_debt_at_maturity
  	@date_of_maturity = Date.parse(@commencement_date) + 90
  	@total_sum        = calc_total_sum
  	@discount_period  = calc_discount_period
  	@debt_at_maturity = (@total_sum / ( 1 + (discount_rate_as_percentage * calc_discounted_term) )).round(2)
  end

  private

  def calc_total_sum
  	(raise NeedTotalSumError, "Need @annual_rate, @duration and @principal") unless total_sum_variables
  	(@principal * (1 + (annual_rate_as_percentage * calc_initial_term)))
  end

  def calc_discount_period
  	(raise NeedDiscountPeriod, "Need @discount_start and @discount_end") unless discount_period_vaiables
  	Date.parse(@discount_end) - Date.parse(@discount_start)
  end

  def total_sum_variables
  	@annual_rate && @duration && @principal
  end

  def discount_period_vaiables
  	@discount_start && @discount_end
  end

  def calc_initial_term
  	(@duration.round(2) / 365.round(2)).round(2)
  end

  def calc_discounted_term
    (@discount_period.round(2) / 365.round(2)).round(7)
  end

  def annual_rate_as_percentage
  	@annual_rate.round(2) / 100
  end

  def discount_rate_as_percentage
  	@discount_rate.round(2) / 100
  end
end
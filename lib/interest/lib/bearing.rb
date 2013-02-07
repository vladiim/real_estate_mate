require_relative '../interest'
require 'date'

# named as in interest bearing loan

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
                :discount_period

  def calc_debt_at_maturity
  	@date_of_maturity = Date.parse(@commencement_date) + 90
  	@total_sum = calc_total_sum
  	@discount_period = calc_discount_period
  end

  private

  def calc_total_sum
  	(raise NeedTotalSumError, "Need @annual_rate, @duration and @principal") unless total_sum_variables
  	(@principal * (1 + (annual_rate_as_percentage * calc_term)))
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

  def calc_term
  	(@duration.round(2) / 365.round(2)).round(2)
  end


  def annual_rate_as_percentage
  	@annual_rate.round(2) / 100
  end
  # d = Date.parse('3rd Feb 2001')
end
require_relative '../interest'
require_relative '../../conversions/time_conversions'

# variables:
# P = principal ($)                   - principal
# r = anuual rate (%)                 - annual_rate
# t = term (years)                    - term
# I = total interest ($)              - total_interest
# S = sum of principal & interest ($) - total_sum

# calculations:
# I = Prt
# S = P + I = P + Prt = P(I + rt)
# p = S / (1 + rt)

class Interest::Simple

  class NeedTotalInterestError < StandardError; end
  
  attr_accessor :principal,      :annual_rate, :term,
                :total_interest, :total_sum,   :term_in_days

  def calc_total_interest
  	return need_total_interest_components unless total_interest_variables
  	 @total_interest = @principal * annual_rate_percentage * @term
     @total_interest = @total_interest.round(2)
  end

  def calc_principal
  	if @total_sum && @annual_rate && @term
  	  @principal = @total_sum / (1.00 + (annual_rate_percentage * @term))
      @principal = @principal.round(2)
  	end
  end

  def calc_total_sum
  	if @principal && @total_interest
      @total_sum = @principal + @total_interest

    elsif total_interest_variables
      @total_sum = @principal + calc_total_interest

    else
      return need_total_interest_components
    end
  end

  def calc_bank_discount
    # I = Prt
    (@total_sum * annual_rate_percentage * term_in_years).round(1)
  end

  private

  def need_total_interest_components
  	raise NeedTotalInterestError, 'Need principal, annual_rate and term'
  end

  def total_interest_variables
  	@principal && @annual_rate && @term
  end

  def principal_variables
  	@total_sum && @total_interest && @annual_rate && @term
  end

  def annual_rate_percentage
    TimeConversions.annual_rate_percentage(@annual_rate)
  end

  def term_in_years
    @term ? @term : TimeConversions.term_in_years(@term_in_days)
  end
end
require_relative '../interest'

class Interest::Simple
  # P = principal ($)
  # r = anuual rate (%)
  # t = term (years)
  # I = total interest ($)
  # S = sum of principal & interest ($)
  # I = Prt
  # S = P + I = P + Prt = P(I + rt)
  # p = S / (I + rt)

  attr_accessor :principal, :annual_rate, :term,
                :total_interest, :total_sum

  def calc_total_interest
  	return need_total_interest_components unless total_interest_variables
  	 unrounded_total_interest = @principal * annual_rate_percentage * @term
     @total_interest = unrounded_total_interest.round(2)
  end

  def calc_principal
  	if principal_variables
  	  @principal = @total_sum / (@total_interest + (annual_rate_percentage * @term))
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

  private

  def need_total_interest_components
  	'Need principal, annual_rate and term'
  end

  def total_interest_variables
  	@principal && @annual_rate && @term
  end

  def principal_variables
  	@total_sum && @total_interest && @annual_rate && @term
  end

  def annual_rate_percentage
    @annual_rate / 100
  end
end
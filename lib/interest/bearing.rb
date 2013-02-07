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

  attr_accessor :date_of_maturity, :commencement_date,
                :annual_rate

  # d = Date.parse('3rd Feb 2001')
end
require_relative '../test_helper'
require_relative '../../lib/interest/lib/bearing'
require 'date'

describe Interest::Bearing do
  before do
  	@interest = Interest::Bearing.new
  end

  describe '#calc_debt_at_maturity' do
  	before do
      @interest.principal         = 800
  	  @interest.duration          = 90 # days
  	  @interest.commencement_date = '18th May 2013'
  	  @interest.annual_rate       = 7   # %
      @interest.discount_rate     = 7.5 # %
      @interest.discount_start    = '6th July 2013'
      @interest.discount_end      = '16th August 2013'
      @interest.calc_debt_at_maturity
  	end

    it 'calculates the total sum as 814.00' do
      @interest.total_sum.must_equal 814.00
    end

    it 'calculates the discount period as 41' do
      @interest.discount_period.must_equal 41
    end

    it 'calculates the debt_at_maturity as 807.20' do
      @interest.debt_at_maturity.must_equal 807.20
    end
  end

  describe '#calc_face_value_of_note' do
    before do
      @interest.term_in_days      = 90
      @interest.annual_rate       = 6
      @interest.customer_proceeds = 2800
    end

    it 'is 2842.64' do
      @interest.calc_face_value_of_note.must_equal 2842.64
    end
  end
end
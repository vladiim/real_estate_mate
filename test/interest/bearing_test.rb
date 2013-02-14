require_relative '../test_helper'
require_relative '../../lib/interest/lib/bearing'
require 'date'

describe Interest::Bearing do
  let(:error) { Interest::Bearing::VariableMissingError }

  before { @interest = Interest::Bearing.new }

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

    describe 'without the right args' do
      let(:variables) { ['principal', 'duration',
          'commencement_date', 'annual_rate',
          'discount_rate', 'discount_start', 'discount_end'] }

      it 'raises an error' do
        variables.each do |varibale|
          @interest.send("#{varibale}=", nil)
          lambda {@interest.calc_debt_at_maturity}.must_raise error
        end
      end
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

  describe '#calc_discount_on_maturity' do
    let(:variables) { %w[term_in_days annual_rate note maturity_time_in_days annual_rate_at_maturity] }
    let(:result)    { @interest.calc_discount_on_maturity }

    before do
      @interest.term_in_days            = 120
      @interest.annual_rate             = 6
      @interest.note                    = 1000
      @interest.maturity_time_in_days   = 30
      @interest.annual_rate_at_maturity = 5
      result
    end

    it 'raises an error if a required variable is missing' do
      variables.each do |variable|
        @interest.send("#{variable}=", nil)
        lambda { result }.must_raise error
      end
    end

    it 'calculates the maturity_value as 1019.8' do
      @interest.maturity_value.must_equal 1019.8
    end

    it 'calculates the leander_discount_on_maturity_value as 12.75' do
      @interest.leander_discount_on_maturity_value.must_equal 12.75
    end

    it 'calculates the leander_proceeds_to_lendee' do
      @interest.leander_proceeds_to_lendee.must_equal 1007.25
    end
  end
end
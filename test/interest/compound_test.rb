require_relative '../test_helper'
require_relative '../../lib/interest/lib/compound'

describe Interest::Compound do
  let(:compound) { Interest::Compound.new }
  let(:error)    { Interest::Compound::VariableMissingError }

  describe '#calc_repayment_ammount' do
  	before do
  	  compound.principal     = 1000
  	  compound.interest      = 6
  	  compound.length_months = 6
  	end

    describe 'with all variables' do
      before { compound.calc_repayment_ammount }

      it 'repayment_interest is 30' do
        compound.repayment_interest.must_equal 30
      end

      it 'repayment_ammount is 1030' do
        compound.repayment_ammount.must_equal 1030
      end
    end

    describe 'variable missing' do
      let(:vars) { %w( principal interest length_months ) }

      it 'raises an error' do
        vars.each do |var|
          compound.send("#{var}=", nil)
          ->{ compound.calc_repayment_ammount }.must_raise error
        end
      end
    end
  end

  describe '#calc_compound_ammount' do
    before do
      compound.principal = 2000
      compound.periods   = 5
      compound.interest_per_period = 2.5
    end

    describe 'with all variables' do
      before { compound.calc_compound_ammount }

      it 'compound_ammount is 2262.82' do
        compound.compound_ammount.must_equal 2262.82
      end
    end

    describe 'variable missing' do
      let(:vars) { %w( principal periods interest_per_period ) }

      it 'raises an error' do
        vars.each do |var|
          compound.send("#{var}=", nil)
          ->{ compound.calc_compound_ammount }.must_raise error
        end
      end
    end
  end

  describe '#calc_interest_per_period' do
    before do
      compound.frequency_of_conversion = 2
      compound.nominal_rate_interest   = 6
    end

    describe 'with all variables' do
      before { compound.calc_interest_per_period }

      it 'interest_per_period is 3' do
        compound.interest_per_period.must_equal 3
      end
    end

    describe 'variable missing' do
      let(:vars) { %w( frequency_of_conversion nominal_rate_interest ) }

      it 'raises an error' do
        vars.each do |var|
          compound.send("#{var}=", nil)
          ->{ compound.calc_interest_per_period }.must_raise error
        end
      end
    end
  end

  describe '#calc_periodic_rate_of_interest' do
    before do
      compound.principal               = 326.4
      compound.periods                 = 20
      compound.frequency_of_conversion = 2
      compound.nominal_rate_interest   = 6
    end

    describe 'with all variables' do
      before { compound.calc_periodic_rate_of_interest }

      it 'interest_per_period is 3' do
        compound.periodic_rate_of_interest.must_equal 589.51
      end
    end

    describe 'variable missing' do
      let(:vars) { %w( principal periods frequency_of_conversion nominal_rate_interest ) }

      it 'raises an error' do
        vars.each do |var|
          compound.send("#{var}=", nil)
          ->{ compound.calc_periodic_rate_of_interest }.must_raise error
        end
      end
    end
  end
end

# P = principal
# i = interest per period
# I = total interest
# n = number of interest periods
# S = compound ammount, sum of compounded principal & interest
# m = freq of conversion
# j = nominal (annual) interest rate
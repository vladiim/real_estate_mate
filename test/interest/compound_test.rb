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
end

# P = principal
# i = interest per period
# I = total interest
# n = number of interest periods
# S = compound ammount, sum of compounded principal & interest
# m = freq of conversion
# j = nominal (annual) interest rate
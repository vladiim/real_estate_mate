require_relative '../test_helper'
require_relative '../../lib/interest/lib/compound'

describe Interest::Compound do
  before { @compound = Interest::Compound.new }

  describe '#calc_repayment_ammount' do
  	before do
  	  @compound.loan          = 1000
  	  @compound.interest      = 6
  	  @compound.length_months = 6
  	  @compound.calc_repayment_ammount
  	end

    it 'repayment_interest is 30' do
      @compound.repayment_interest.must_equal 30
    end

    it 'repayment_ammount is 1030' do
      @compound.repayment_ammount.must_equal 1030
    end
  end
end
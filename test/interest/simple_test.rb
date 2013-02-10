require_relative '../test_helper'
require_relative '../../lib/interest/lib/simple'

describe Interest::Simple do
  before do
  	@interest = Interest::Simple.new
  end

  describe '#calc_total_interest' do
    describe 'with total interest variables' do
	    before do
	      @interest.principal   = 1750
	      @interest.annual_rate = 4.5
	      @interest.term        = 0.36
	      @interest.calc_total_interest
	    end
	    
	    it 'returns 28.35' do
	      @interest.total_interest.must_equal 28.35
	    end
    end

    describe 'without total interest variables' do
      let(:error) { Interest::Simple::NeedTotalInterestError }

      it 'should raise a NeedTotalInterestError' do
        lambda {@interest.calc_total_interest}.must_raise error
      end
    end
  end

  describe 'principal calcs' do
  	before do
	  @interest.total_sum   = 5000
	  @interest.annual_rate = 5
	  @interest.term        = 1
  	end

    describe '#calc_principal' do
      before { @interest.calc_principal }

      it 'returns 4761.90' do
        @interest.principal.must_equal 4761.90
      end
    end
  end

  describe '#calc_bank_discount' do
    before do
      @interest.total_sum    = 200
      @interest.term_in_days = 90
      @interest.annual_rate  = 6
    end

    it 'returns 3' do
      @interest.calc_bank_discount.must_equal 3
    end
  end
end
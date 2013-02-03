require_relative '../test_helper'
require_relative '../../lib/interest/lib/simple'

describe Interest::Simple do
  before do
  	@interest = Interest::Simple.new
  end

  describe '#calc_total_interest' do
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

  describe '#calc_principal' do
  	before do
	  @interest.total_sum   = 5000
	  @interest.annual_rate = 5
	  @interest.term        = 1
	  @interest.calc_principal
  	end

    it 'returns 4761.90' do
      @interest.principal.must_equal 4761.90
    end
  end
end
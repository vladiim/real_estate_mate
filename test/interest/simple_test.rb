require_relative '../test_helper'
require_relative '../../lib/interest/lib/simple'

describe Interest::Simple do
  before do
  	@interest = Interest::Simple.new
  end

  describe '#calc_total_interest' do
  	# describe 'with total_interest_variables' do
	before do
	  @interest.principal   = 1750
	  @interest.annual_rate = 4.5
	  @interest.term        = 0.36
	end
	    
	it 'is 28.35' do
	  @interest.calc_total_interest.must_equal 28.35
	end
  	# end
  end
end
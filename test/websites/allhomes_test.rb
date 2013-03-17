require_relative '../test_helper'
require_relative '../../lib/init'

describe Allhomes do
  let(:site) { Allhomes }

  describe 'states' do
  	it 'stores the states' do
  	  site.act.must_equal States::Act
  	  site.nsw.must_equal States::Nsw
  	  site.qld.must_equal States::Qld
  	  site.vic.must_equal States::Vic
  	  site.tas.must_equal States::Tas
  	  site.nt.must_equal States::Nt
  	  site.sa.must_equal States::Sa
    end
  end
end
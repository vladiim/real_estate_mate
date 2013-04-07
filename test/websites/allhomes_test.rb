require_relative '../test_helper'
require_relative '../../lib/init'

describe Allhomes do
  let(:site) { Allhomes }

  describe '.links' do
    let(:act)    { OpenStruct.new suburb_links: 'ACT LINK' }
    let(:result) { site.links }

    before { mock(site).states { [act] } }

    it 'returns the links to the state suburbs' do
      result.must_equal ['ACT LINK']
    end
  end
end
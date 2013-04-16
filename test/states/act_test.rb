require_relative '../test_helper'
require_relative '../../lib/states/act'

describe States::Act do
  describe '.allhomes_suburb_links' do
  	let(:url)    { 'http://www.allhomes.com.au/ah/act/sale-residential' }
    let(:result) { States::Act.allhomes_suburb_links }

    before do
      page = File.read("#{Dir.pwd}/test/fixtures/allhomes/act_index.html")
      FakeWeb.register_uri(:get, url, body: page, content_type: 'text/html')
    end

    it 'returns 168 links' do
      result.count.must_equal 165
    end
  end
end
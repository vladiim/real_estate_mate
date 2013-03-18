require_relative '../../test_helper'
require_relative '../../../lib/scrapers/allhomes/scraper'

describe Allhomes::Scraper do
  let(:scraper)   { Allhomes::Scraper.new }
  let(:site)      { Allhomes }

  describe '.initialize' do
    it 'composes collaborators' do
      scraper.agent.class.must_equal Mechanize
      scraper.site.must_equal site
    end
  end

  describe '#get_pages' do
    let(:link)   { Object.new }
    let(:page)   { Object.new }
    let(:result) { scraper.get_pages }

    before do
      agent = scraper.agent
      mock(site).links { [link] }
      mock(agent).get(link) { page }
    end

    it 'returns the pages' do
      result.must_equal [page]
    end
  end

  # describe '#find_listings' do
  #   let(:listings) { Object.new }

  #   before { scraper.find_listings }

  #   it 'returns the listed houses' do
  #     scraper.listings.should eq listings
  #   end
  # end
end
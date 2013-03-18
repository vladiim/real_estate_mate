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

  describe '#find_listings' do
    let(:listings) { Object.new }
    let(:result)   { scraper.find_listings }

    before { mock(scraper).get_pages { MockPage.new(listings) } }

    it 'returns the listed houses' do
      scraper.find_listings
      scraper.listings.must_equal [listings]
    end
  end
end

class MockPage
  def initialize(listings)
    @listings = listings
  end

  def search(term)
    if term == 'tbody'
      [self]
    else
      @listings
    end
  end
end
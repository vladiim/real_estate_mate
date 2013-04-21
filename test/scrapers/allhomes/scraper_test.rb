require_relative '../../test_helper'
require_relative '../../../lib/scrapers/allhomes/scraper'

describe Allhomes::Scraper do
  module Allhomes; URL='http://www.allhomes.com.au'; end
  let(:scraper)   { Allhomes::Scraper.new }
  let(:site)      { Allhomes }

  describe '.initialize' do
    it 'composes collaborators' do
      scraper.agent.class.must_equal Mechanize
      scraper.site.must_equal site
    end
  end

  describe '#find_listings' do
    let(:url)  { 'http://allhomes.com/aranda' }

    before do
      mock(Allhomes).links { [url] }
      page = File.read("#{Dir.pwd}/test/fixtures/allhomes/aranda_index.html")
      FakeWeb.register_uri(:get, url, body: page, content_type: 'text/html')
    end

    it 'correctly finds the first listings details' do
      scraper.find_listings
      listing = scraper.listings[0]
      listing.url.must_equal "http://www.allhomes.com.au/ah/act/sale-residential/25-bindaga-street-aranda-canberra/1316838381311"
      listing.address.must_equal 'Aranda 25 Bindaga Street'
      listing.price.must_equal 660000
      listing.bedrooms.must_equal 3
      listing.bathrooms.must_equal 1
      listing.property_type.must_equal 'House'

      listing.postcoe.must_equal 'NEED POSTCODE!!!'
    end
  end

  describe '#save_listings' do
    let(:listing)  { OpenStruct.new(url: 'URL', address: 'ADDRESS', price: 'PRICE', bedrooms: 'BED', bathrooms: 'BATH', property_type: 'TYPE') }
    let(:csv_file) { [] }
    class CSV; end

    before do
      mock_csv
      mock(scraper).listings { [listing] }
    end

    it 'saves the listing to a csv document' do
      scraper.save_listings
      csv_file.must_equal [['URL', 'ADDRESS', 'PRICE', 'BED', 'BATH', 'TYPE', 'allhomes']]

      # working scrap code:
      # CSV.open("#{Dir.pwd}/path/to/csv.csv") do |csv|
      #   scraper.listings.each do |l|
      #     csv << [l.url, l.address, l.price ....]
      #   end
      # end
    end
  end
end

def mock_csv
  mock(scraper).today { 'TODAY' }
  mock(CSV).open("#{Dir.pwd}/lib/data/TODAY.csv", 'wb') { csv_file }
end
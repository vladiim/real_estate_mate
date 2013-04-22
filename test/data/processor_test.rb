require_relative '../test_helper'
require_relative '../../lib/data/data_processor'

describe DataProcessor do
  let(:processor) { DataProcessor.new(listings) }
  let(:listing)   { OpenStruct.new(url: 'URL', address: 'ADDRESS', price: 'PRICE', bedrooms: 'BED', bathrooms: 'BATH', property_type: 'TYPE', from: 'FROM', date: 'DATE') }
  let(:listings)  { [listing] }

  describe '#initialize' do
  	it 'sets the listings as a variable' do
  	  processor.listings.must_equal listings
  	end
  end

  describe '#save' do
    let(:csv_file) { Array.new }
    let(:result)   { [['URL', 'ADDRESS', 'PRICE', 'BED', 'BATH', 'TYPE', 'FROM', 'DATE']] }
    class CSV; end

    before { mock_csv }

    it 'saves the listing to a csv document' do
      processor.save
      csv_file.must_equal result
    end
  end
end

def mock_csv
  mock(processor).today { 'TODAY' }
  mock(CSV).open("#{Dir.pwd}/lib/data/stored/TODAY.csv", 'wb') { csv_file }
end
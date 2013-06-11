require 'mechanize'
require 'csv'

module Allhomes
  class Scraper
    attr_reader :agent, :site, :links, :base_url, :listings, :postcode

    def initialize
    	@agent, @site, @base_url, @listings = Mechanize.new, Allhomes, Allhomes::URL, []
    end

    def find_listings
    	pages = get_pages
    	tbody = find_listing_tables(pages)
      format_listings(tbody)
    end

    def save_listings
      DataProcessor.new(listings).save
    end

    private

    def get_pages
    	site.links.each.inject([]) do |pages, link|
        puts "Getting page #{pages.length}"
        pages << get_page(pages.length, link)
    	end
    end

    def get_page(pages_length, link)
      begin
        agent.get(link)
      rescue Exception => e
        puts "Failed to get page number #{pages_length} because of: #{e.message}"
      end
    end

    def find_listing_tables(pages)
      pages.each.inject([]) do |tbodies, page|
        @postcode = find_postcode(page)
        puts "Finding listings for #{postcode}"
    	  tbodies << page.search('tbody')
      end
    end

    def format_listings(tbody)
    	tbody.each do |group|
    	  page_listings = group.search('tr')
        page_listings.each { |listing| process_list_item(listing) }
    	end	
    end

    def process_list_item(listing)
      begin
        create_list_item(listing)
      rescue Exception => e
        puts "Failed to get listing #{listing} because of: #{e.message}"
      end
    end

    def create_list_item(listing)
      puts "Creating list item #{listings.count}"
      list_item               = OpenStruct.new
      list_item.url           = base_url + listing.search('.listingRecordSummaryDetails a')[0].attributes['href'].value
      list_item.address       = listing.search('.listingRecordSummaryDetails a')[0].content
      list_item.price         = format_price(listing)
      list_item.bedrooms      = listing.search('td:nth-of-type(4)').children.text.to_i
      list_item.bathrooms     = listing.search('td:nth-of-type(5)').children.text.to_i
      list_item.property_type = listing.search('td:nth-of-type(6)').children.text
      list_item.from          = 'allhomes'
      list_item.postcode      = postcode
      list_item.date          = TimeConversions.today
      listings << list_item
    end

    def format_price(listing)
      price = listing.search('td:nth-of-type(3)').children.text
      price = price.gsub('$', '').gsub(',', '').to_i if price.match(/^\$/)
      price
    end

    def find_postcode(page)
      begin
        page.search('#left_container .column p').search('strong')[1].children.text.match(/\d+/)[0].to_i
      rescue NoMethodError
        'other'
      end
    end
  end
end
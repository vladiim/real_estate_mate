require 'mechanize'

module Allhomes
  class Scraper
    attr_reader :agent, :site, :links, :base_url, :listings

    def initialize
    	@agent, @site, @base_url, @listings = Mechanize.new, Allhomes, Allhomes::URL, []
    end

    def find_listings
    	pages = get_pages
    	tbody = find_listing_tables(pages)
      format_listings(tbody)
    end

    def save_listings
      CSV.open("#{Dir.pwd}/lib/data/#{today}.csv", "wb") do |csv|
        listings.each do |listing|
          csv << [listing.url, listing.address, listing.price, listing.bedrooms, 
                  listing.bathrooms, listing.property_type, 'allhomes']
        end
      end
    end

    private

    def get_pages
    	site.links.each.inject([]) do |pages, link|
    	  pages << agent.get(link)
    	end
    end

    def find_listing_tables(pages)
      pages.each.inject([]) do |tbodies, page|
    	  tbodies << page.search('tbody')
      end
    end

    def format_listings(tbody)
    	tbody.each do |group|
    	  page_listings = group.search('tr')
        page_listings.each { |listing| create_list_item(listing) }
    	end	
    end

    def create_list_item(listing)
      list_item               = OpenStruct.new
      list_item.url           = base_url + listing.search('.listingRecordSummaryDetails a')[0].attributes['href'].value
      list_item.address       = listing.search('.listingRecordSummaryDetails a')[0].content
      list_item.price         = format_price(listing)
      list_item.bedrooms      = listing.search('td:nth-of-type(4)').children.text.to_i
      list_item.bathrooms     = listing.search('td:nth-of-type(5)').children.text.to_i
      list_item.property_type = listing.search('td:nth-of-type(6)').children.text
      listings << list_item
    end

    def format_price(listing)
      price = listing.search('td:nth-of-type(3)').children.text
      price = price.gsub('$', '').gsub(',', '').to_i if price.match(/^\$/)
      price
    end

    def today
      "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}"
    end
  end
end
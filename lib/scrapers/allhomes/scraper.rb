require_relative '../../websites/allhomes'
require 'mechanize'

class Allhomes::Scraper
  attr_reader :agent, :site, :links, :base_url, :listings

  def initialize
  	@agent, @site, @base_url, @listings = Mechanize.new, Allhomes, Allhomes::URL, []
  end

  def find_listings
  	pages = get_pages
  	tbody = find_listing_tables(pages)
    store_listings(tbody)
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

  def store_listings(tbody)
  	tbody.each do |group|
  	  page_listings = group.search('tr')
      page_listings.each { |listing| create_list_item(listing) }
  	end	
  end

  def create_list_item(listing)
    debugger
    list_item = OpenStruct.new
    list_item.url     = base_url + listing.search('.listingRecordSummaryDetails a')[0].attributes['href'].value
    list_item.address = listing.search('.listingRecordSummaryDetails a')[0].content
    listings << list_item
  end
end
require_relative '../../websites/allhomes'
require 'mechanize'

class Allhomes::Scraper
  attr_reader :agent, :site, :links, :listings

  def initialize
  	@agent, @site = Mechanize.new, Allhomes
  end

  def find_listings
  	pages     = get_pages
  	@listings = []
  	tbody     = find_table_bodies(pages)
    find_table_rows(tbody)
  end

  private

  def get_pages
  	site.links.each.inject([]) do |pages, link|
  	  pages << agent.get(link)
  	end
  end

  def find_table_bodies(pages)
  	pages.search 'tbody'
  end

  def find_table_rows(tbody)
  	tbody.each do |group|
  	  listings << group.search('tr')
  	end	
  end
end
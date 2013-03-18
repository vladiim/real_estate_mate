require_relative '../../websites/allhomes'
require 'mechanize'

class Allhomes::Scraper
  attr_reader :agent, :site, :links

  def initialize
  	@agent, @site = Mechanize.new, Allhomes
  end

  def get_pages
  	site.links.each.inject([]) do |pages, link|
  	  pages << agent.get(link)
  	end
  end
end
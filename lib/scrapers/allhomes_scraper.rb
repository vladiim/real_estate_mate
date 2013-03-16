require_relative '../websites/allhomes'
require 'mechanize'

class Allhomes::Scraper
  attr_reader :worker, :site

  def initialize
  	@worker, @site = Mechanize.new, Allhomes
  end

  
end
require_relative '../../websites/allhomes'
require 'mechanize'

class Allhomes::Scraper
  attr_reader :agent, :site, :links

  def initialize(mechanize = Mechanize.new)
  	@agent, @site = mechanize, Allhomes
  end

  def find_state_links(state)
  	state_obj = find_state(state)
  	@links    = state_index_page_links(state_obj)
  end

  private

  def find_state(state)
  	site.public_send state
  end

  def state_index_page_links(state)
    url = state.allhomes_index_url
    agent.get(url).links
  end
end
require 'mechanize'
require_relative '../websites/allhomes'

module States
  module Nsw
  	ALLHOMES_BASE_URL = "http://www.allhomes.com.au/ah/nsw/sale-residential"
  	ALLHOMES_INDEX = ["#{ALLHOMES_BASE_URL}/albury-wodonga-region/1064710",
  	                  "#{ALLHOMES_BASE_URL}/central-coast/1041710",
  	                  "#{ALLHOMES_BASE_URL}/central-north/1042710",
  	                  "#{ALLHOMES_BASE_URL}/central-west/1043710",
  	                  "#{ALLHOMES_BASE_URL}/hunter/1044710",
  	                  "#{ALLHOMES_BASE_URL}/illawarra/1045710",
  	                  "#{ALLHOMES_BASE_URL}/murray/1046710",
  	                  "#{ALLHOMES_BASE_URL}/north-coast/1047710",
  	                  "#{ALLHOMES_BASE_URL}/north-west/1048710",
  	                  "#{ALLHOMES_BASE_URL}/queanbeyan-region/1055710",
  	                  "#{ALLHOMES_BASE_URL}/riverina/1050710",
  	                  "#{ALLHOMES_BASE_URL}/snowy/1054710",
  	                  "#{ALLHOMES_BASE_URL}/south-coast/1051710",
  	                  "#{ALLHOMES_BASE_URL}/southern-highlands-region/1063710",
  	                  "#{ALLHOMES_BASE_URL}/southern-tablelands/1053710",
  	                  "#{ALLHOMES_BASE_URL}/sydney/1052710"]

  	def self.allhomes_suburb_links
  	  ALLHOMES_INDEX.each do |index_url|
        States.get_state_links(index_url)
  	  end
  	end
  end
end
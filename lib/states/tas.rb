module States
  module Tas
  	ALLHOMES_BASE_URL = "http://www.allhomes.com.au/ah/tas/sale-residential"
  	ALLHOMES_INDEX = ["#{ALLHOMES_BASE_URL}/greater-hobart/1058710",
  	                  "#{ALLHOMES_BASE_URL}/north-east/1040710",
  	                  "#{ALLHOMES_BASE_URL}/north-west/1049710",
  	                  "#{ALLHOMES_BASE_URL}/southern/1057710",
  	                  "#{ALLHOMES_BASE_URL}/west/1056710"]

  	def self.allhomes_suburb_links
  	  ALLHOMES_INDEX.each do |index_url|
        States.get_state_links(index_url)
  	  end
  	end
  end
end
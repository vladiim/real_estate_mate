require 'mechanize'
require_relative '../websites/allhomes'

module States
  module Act
    ALLHOMES_INDEX = 'http://www.allhomes.com.au/ah/act/sale-residential'

    def self.allhomes_suburb_links
      States.get_state_links(ALLHOMES_INDEX)
    end
  end
end
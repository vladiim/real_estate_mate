module States
  module Act
  	def self.allhomes_suburb_links
      [ allhomes_aranda, allhomes_belconnen, allhomes_belconnen_town_centre]
  	end

    private

    def self.allhomes_aranda
      'http://www.allhomes.com.au/ah/act/sale-residential/aranda/121461710'
    end

    def self.allhomes_belconnen
      'http://www.allhomes.com.au/ah/act/sale-residential/belconnen/121477710'
    end

    def self.allhomes_belconnen_town_centre
      'http://www.allhomes.com.au/ah/act/sale-residential/belconnen-town-centre/121899710'
    end
  end
end
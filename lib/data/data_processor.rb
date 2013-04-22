class DataProcessor
  attr_reader :listings

  def initialize(listings)
  	@listings = listings
  end

  def save
	CSV.open("#{Dir.pwd}/lib/data/stored/#{today}.csv", "wb").tap do |csv|
		add_listings_to csv
	end
  end

  private

  def add_listings_to(csv)
	listings.each { |listing| add_listing_to(csv, listing) }
  end

  def add_listing_to(csv, listing)
    csv << [listing.url,       listing.address,       listing.price, listing.bedrooms, 
	        listing.bathrooms, listing.property_type, listing.from,  listing.date]
  end

  def today
    TimeConversions.today
  end
end
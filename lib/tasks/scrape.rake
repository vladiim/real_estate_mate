require "#{Dir.pwd}/lib/init.rb"

namespace 'scrape' do
  desc 'scrape and save allhomes'
  task :allhomes do
  	scraper = Allhomes::Scraper.new
    scraper.find_listings
    scraper.save_listings
  end

  task all: [:allhomes]
end
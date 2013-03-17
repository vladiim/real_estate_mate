# require "#{Dir.pwd}/lib/init.rb"

require 'mechanize'

def require_top_level_dir(dir)
  Dir["#{Dir.pwd}/lib/#{dir}/*.rb"].each { |f| require f }
end

def require_sub_level_dir(dir)
  require_top_level_dir("#{dir}/**")
end

# Require interest
require_sub_level_dir('interest')
# Dir["#{Dir.pwd}/lib/interest/**/*.rb"].each { |f| require f }

# Require conversions
require_top_level_dir('conversions')
# Dir["#{Dir.pwd}/lib/conversions/*.rb"].each { |f| require f }

# Require websites
require_top_level_dir('websites')
# Dir["#{Dir.pwd}/lib/websites/*.rb"].each { |f| require f }

# Require states
require_top_level_dir('states')

# Require scrapers
require_sub_level_dir('scrapers')
# Dir["#{Dir.pwd}/lib/scrapers/**/*.rb"].each { |f| require f }
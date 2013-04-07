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

# Require conversions
require_top_level_dir('conversions')

# Require websites
require_top_level_dir('websites')

# Require states
require_top_level_dir('states')

# Require scrapers
require_sub_level_dir('scrapers')
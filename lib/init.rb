# to init in irb
# > require "#{Dir.pwd}/lib/init.rb"

require_relative 'interest/interest'
require_relative 'interest/lib/bearing'
require_relative 'interest/lib/simple'

Dir["#{Dir.pwd}/lib/conversions/*.rb"].each { |f| require f }
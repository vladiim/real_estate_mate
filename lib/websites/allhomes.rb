Dir["#{Dir.pwd}/lib/states/*.rb"].each { |f| require f }

module Allhomes

  URL = 'http://www.allhomes.com.au'

  def self.links
    states.each.inject([]) do |all_links, state|
      all_links << state.allhomes_suburb_links
      all_links.flatten
    end
  end

  def self.states
    [act]
    # [act, nsw, qld, vic, tas, nt, sa]
  end

  private

  def self.act
  	States::Act
  end

  def self.nsw
  	States::Nsw  	
  end

  def self.qld
  	States::Qld
  end

  def self.vic
  	States::Vic
  end

  def self.tas
  	States::Tas
  end

  def self.nt
  	States::Nt
  end

  def self.sa
  	States::Sa
  end
end
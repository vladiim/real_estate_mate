Dir["#{Dir.pwd}/lib/states/*.rb"].each { |f| require f }

module Allhomes

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
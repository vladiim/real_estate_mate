# require_relative '../conversions'

module TimeConversions

  def self.term_in_years(term_in_days)
    (term_in_days.round(2) / 365).round(2)
  end

  def self.annual_rate_percentage(annual_rate)
  	annual_rate.round(2) / 100
  end
end
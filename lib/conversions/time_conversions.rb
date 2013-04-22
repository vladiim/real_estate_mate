# require_relative '../conversions'

module TimeConversions

  def self.term_in_years(term_in_days)
    (term_in_days.round(2) / 365).round(2)
  end

  def self.annual_rate_percentage(annual_rate)
  	annual_rate.round(2) / 100
  end

  def self.days_between(first_date, second_date)
  	if first_date_earlier?(first_date, second_date)
  	  subtract_days(second_date, first_date)
  	else
      subtract_days(first_date, second_date)
  	end
  end

  def self.to_date(date)
    Date.strptime(date, '%d-%m-%Y')
  end

  def self.today
    "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}"
  end

  private

  def self.first_date_earlier?(first_date, second_date)
  	Date.parse(first_date) < Date.parse(second_date)
  end

  def self.subtract_days(first_date, second_date)
  	(Date.parse(first_date) - Date.parse(second_date)).to_i
  end
end
require 'faraday'
require 'json'
require 'pry'
class DateService
  attr_reader :holidays

  def initialize
  @holidays = get_upcoming_holidays
  end

  def get_upcoming_holidays
    resp =  Faraday.get('https://date.nager.at/Api/v2/NextPublicHolidays/US')
    parsed = JSON.parse(resp.body, symbolize_names: true)
    upcoming_holidays = parsed[0..2]
  end
end



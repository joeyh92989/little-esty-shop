require 'faraday'
require 'json'
require 'pry'
class DateService
  attr_reader :holiday,

  def initialize
  @holiday ||= get_upcoming_holidays

  end

  def get_upcoming_holidays
    resp =  Faraday.get('https://date.nager.at/Api/v2/NextPublicHolidays/US')
    parsed = JSON.parse(resp.body, symbolize_names: true)
    upcoming_holidays = parsed[0..3]
    binding.pry
  end
end

test = DateService.new
test.get_upcoming_holidays


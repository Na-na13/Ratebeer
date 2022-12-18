require 'net/http'
require 'json'

class BeerweatherApi
  def self.get_weather(city)
    params = {
        :access_key => key,
        :query => city.downcase
      }
      uri = URI('http://api.weatherstack.com/current')
    uri.query = URI.encode_www_form(params)
    json = Net::HTTP.get(uri)
    api_response = JSON.parse(json)

    @weather = {
        :temperature => api_response['current']['temperature'],
        :icons => api_response['current']['weather_icons'],
        :wind_speed => api_response['current']['wind_speed'],
        :wind_dir => api_response['current']['wind_dir']
      }
  end

  def self.key
    return nil if Rails.env.test? # testatessa ei apia tarvita, palautetaan nil
    raise 'BEERWEATHER_APIKEY env variable not defined' if ENV['BEERWEATHER_APIKEY'].nil?
    ENV.fetch('BEERWEATHER_APIKEY')
  end
end

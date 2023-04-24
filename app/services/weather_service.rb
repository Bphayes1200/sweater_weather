class WeatherService
  def self.get_five_day_forecast(params)
    get_url("/forecast.json?#{params}&days=5")
    require 'pry'; binding.pry
  end



  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end


 private

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com/v1" ) do |farady|
      faraday.headers["key"] = ENV["WEATHER_API_KEY"]
    end
  end
end

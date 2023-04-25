class WeatherService
  def self.get_five_day_forecast_and_current(lat, lng)
    get_url("/forecast.json?#{lat},#{lng}&days=5")
  end



  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end


 private

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com/v1" ) do |faraday|
      faraday.headers["key"] = ENV["WEATHER_API_KEY"]
    end
  end
end

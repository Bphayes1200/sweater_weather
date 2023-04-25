class WeatherFacade 
  def self.get_weather(location)
    location_lat_long = LocationService.get_latlong(location)
    location_forecast = WeatherService.get_five_day_forecast_and_current(location_lat_long[:lat], location_lat_long[:lng])
  end
end
class WeatherFacade 
  def self.get_weather(location)
    location_lat_long = LocationService.get_latlong(location)
    location_forecast = WeatherService.get_five_day_forecast_and_current(location_lat_long[:lat], location_lat_long[:lng])
  end

  def self.get_datetime_weather(location, date, hour)
    datetime_weather =  WeatherService.get_specific_day_weather(location, date, hour)
    {
      datetime: datetime_weather[:forecast][:forecastday][0][:hour][0][:time],
      temperature:  datetime_weather[:forecast][:forecastday][0][:hour][0][:temp_f],
      condition: datetime_weather[:forecast][:forecastday][0][:hour][0][:condition][:text]
    }
  end
end
class WeatherSerializer
  include JSONAPI::Serializer
  
  set_type :forecast
  set_id { nil }

  attribute :current_weather do |weather|
    {
    last_updated: weather[:current][:last_updated],
    temperature: weather[:current][:temp_f],
    feels_like: weather[:current][:feelslike_f],
    humidity: weather[:current][:humidity],
    uvi: weather[:current][:uv],
    visibility: weather[:current][:vis_miles],
    condition: weather[:current][:condition][:text],
    icon: weather[:current][:condition][:icon]
  }
  end 

  attribute :daily_weather do |weather|
    weather[:forecast][:forecastday].map do |day|
      {
      date: day[:date],
      sunrise: day[:astro][:sunrise],
      sunset: day[:astro][:sunset],
      max_temp: day[:day][:maxtemp_f],
      min_temp: day[:day][:mintemp_f],
      condition: day[:day][:condition][:text],
      icon: day[:day][:condition][:icon]
      }
    end
  end

  attribute :hourly_weather do |weather|
    weather[:forecast][:forecastday][0][:hour].map do |hour|
      {
      time: hour[:time].to_datetime.strftime("%H"),
      temperature: hour[:temp_f],
      conditions: hour[:condition][:text],
      icon:  hour[:condition][:icon]
      }
    end
  end
end

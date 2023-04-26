class RoadTripFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def get_road_trip
    trip = LocationService.get_directions(@origin, @destination)
    unless trip[:info][:messages][0] == "We are unable to route with the given locations."
      destination_lat_lng = LocationService.get_latlong(@destination)
      arrival_time_at_location = Time.now + trip[:route][:time]
      formatted_date = arrival_time_at_location.strftime("%F")
      formatted_hour =  arrival_time_at_location.strftime("%k")

      arrival_weather_at_location = WeatherFacade.get_datetime_weather(destination_lat_lng, formatted_date, formatted_hour)
      {
        start_city: @origin, 
        end_city: @destination, 
        travel_time: trip[:route][:formattedTime],
        weather_at_eta: {
          datetime: arrival_weather_at_location[:datetime],
          temperature: arrival_weather_at_location[:temperature],
          condition: arrival_weather_at_location[:condition]

        }
      }
    else
      {
        start_city: @origin, 
        end_city: @destination, 
        travel_time: "impossible route"
      }
    end 
  end
end
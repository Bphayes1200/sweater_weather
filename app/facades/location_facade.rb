class LocationFacade
  def self.get_route_time(to, from)
    route = LocationService.get_directions(to, from)
    route[:route][:formattedTime]
  end
end
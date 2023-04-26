class RoadTripSerializer
  include JSONAPI::Serializer

  set_type :road_trip 
  set_id { nil }

  attribute :start_city do |data|
    data[:start_city]
  end

  attribute :end_city do |data|
    data[:end_city]
  end

  attribute :travel_time do |data| 
    data[:travel_time]
  end

  attribute :weather_at_eta do |data|
    data[:weather_at_eta]
  end
end

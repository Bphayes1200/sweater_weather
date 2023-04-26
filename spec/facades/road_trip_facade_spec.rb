require "rails_helper"

RSpec.describe RoadTripFacade do
  before :each do 
    directions_den_to_slc = File.read("spec/fixtures/directions_from_denver_to_salt_lake.json")
    stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=Denver,CO&to=Salt%20Lake%20City,UT")
      .to_return(status: 200, body: directions_den_to_slc)

    salt_lake = File.read("spec/fixtures/salt_lake_location.json")
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?location=Salt%20Lake%20City,UT")
      .to_return(status: 200, body: salt_lake)

    sl_datetime = File.read("spec/fixtures/salt_lake_datetime_weather.json")
      stub_request(:get, "http://api.weatherapi.com/forecast.json?40.76031,-111.88822&dt=2023-04-26&hour=10")
      .to_return(status: 200, body: sl_datetime)

    nyc_london = File.read("spec/fixtures/nyc_to_london.json")
    stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=New%20York,NY&to=London,UK")
    .to_return(status: 200, body: nyc_london)

    london = File.read("spec/fixtures/london_location.json")
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?location=London,UK")
    .to_return(status: 200, body: london)
    
  end
  it "will return a road trip" do 
    facade = RoadTripFacade.new("Denver,CO", "Salt Lake City,UT")
    road_trip = facade.get_road_trip

    expect(road_trip[:start_city]).to eq("Denver,CO")
    expect(road_trip[:end_city]).to eq("Salt Lake City,UT")
    expect(road_trip[:travel_time]).to eq("07:40:26")
    expect(road_trip[:weather_at_eta][:datetime]).to eq("2023-04-26 08:00")
    expect(road_trip[:weather_at_eta][:temperature]).to eq(41.7)
    expect(road_trip[:weather_at_eta][:condition]).to eq("Sunny")
  end

  it "will return an impossible route" do 
    facade = RoadTripFacade.new("New York,NY", "London,UK")
    road_trip = facade.get_road_trip

    expect(road_trip[:start_city]).to eq("New York,NY")
    expect(road_trip[:end_city]).to eq("London,UK")
    expect(road_trip[:travel_time]).to eq("impossible route")
  end
end
require "rails_helper"

RSpec.describe "Road Trip request" do 
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

    @user = User.create!(id: 1, email: "brian@example.com", password: "password", password_confirmation: "password")
    @api_key = ApiKey.create!(user_id: @user.id )
  end
  it "will return road trip data" do 
    road_trip_data = { 
      "origin": "Denver,CO",
      "destination": "Salt Lake City,UT",
      "api_key": @api_key[:access_token]
      }

  headers = {"CONTENT_TYPE" => "application/json"}

  post "/api/v1/road_trip", headers: headers , params: JSON.generate(road_trip_data)

  expect(response.status).to eq(200)
  data = JSON.parse(response.body, symbolize_names: true)

  expect(data[:data][:id]).to eq(nil)
  expect(data[:data][:type]).to eq("road_trip")
  expect(data[:data][:attributes][:start_city]).to eq("Denver,CO")
  expect(data[:data][:attributes][:end_city]).to eq("Salt Lake City,UT")
  expect(data[:data][:attributes][:travel_time]).to eq("07:40:26")
  expect(data[:data][:attributes][:weather_at_eta][:datetime]).to eq("2023-04-26 08:00")
  expect(data[:data][:attributes][:weather_at_eta][:temperature]).to eq(41.7)
  expect(data[:data][:attributes][:weather_at_eta][:condition]).to eq("Sunny")
  end

  it "will return Unathorized if key does not exist" do 
    user2 = User.create!(id: 2, email: "brian123@example.com", password: "password", password_confirmation: "password")
    api_key2 = ApiKey.create!(user_id: user2.id )

    road_trip_data = { 
      "origin": "Denver,CO",
      "destination": "Salt Lake City,UT",
      "api_key": 12334
      }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/road_trip", headers: headers , params: JSON.generate(road_trip_data)

    data = JSON.parse(response.body, symbolize_names: true)
   
    expect(data[:errors][0][:status]).to eq(401)
    expect(data[:errors][0][:message]).to eq("Unauthorized Request")
  end
end
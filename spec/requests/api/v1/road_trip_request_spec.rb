require "rails_helper"

RSpec.describe "Road Trip request" do 
  before :each do 
    @user = User.create(id: 1, email: "brian@example.com", password: "password")
    @api_key = ApiKey.create(access_token: 123456789, user_id: @user.id )
  end
  it "will return road trip data" do 
    road_trip_data = { 
      "origin": "Denver,CO",
      "destination": "Salt Lake City,UT",
      "api_key": 123456789
      }

  headers = {"CONTENT_TYPE" => "application/json"}

  post "/api/v1/road_trip", headers: headers , params: JSON.generate(road_trip_data)

  expect(response.status).to eq(200)
  end
end
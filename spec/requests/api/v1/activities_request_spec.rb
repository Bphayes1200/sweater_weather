require "rails_helper"

RSpec.describe "Activities Request" do 
  before :each do 
    denver_five_day_forecast = File.read("spec/fixtures/denver_five_day_forecast.json")
    stub_request(:get, "http://api.weatherapi.com/forecast.json?39.74001,-104.99202&days=5")
      .to_return(status: 200, body: denver_five_day_forecast)

    denver = File.read("spec/fixtures/denver_location.json")
    stub_request(:get, "https://www.mapquestapi.com/address?location=denver,co")
      .to_return(status: 200, body: denver)
  end
  it "will return a response with a destination, forecast, and two activities" do 

    get "/api/v1/activities?destination=denver,co"

    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data][:id]).to eq(nil)
    expect(data[:data][:attributes][:destination]).to eq("denver,co")
  end
end
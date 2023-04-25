require "rails_helper"

RSpec.describe "Activities Request" do 
  before :each do 
    rec_activity = File.read("spec/fixtures/recreational_activity.json")
    stub_request(:get, "http://www.boredapi.com/activity?type=recreational")
      .to_return(status: 200, body: rec_activity)

    cooking_activity = File.read("spec/fixtures/cooking_activity.json")
    stub_request(:get, "http://www.boredapi.com/activity?type=cooking")
      .to_return(status: 200, body: cooking_activity)

    relax_activity = File.read("spec/fixtures/relaxation_activity.json")
    stub_request(:get, "http://www.boredapi.com/activity?type=relaxation")
      .to_return(status: 200, body: relax_activity)

    busywork_activity = File.read("spec/fixtures/busywork_activity.json")
    stub_request(:get, "http://www.boredapi.com/activity?type=busywork")
      .to_return(status: 200, body: busywork_activity)

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
    expect(data[:data][:attributes][:destination]).to eq("Denver")
    expect(data[:data][:type]).to eq("activities")
    expect(data[:data][:attributes][:forecast][:summary]).to eq("Partly cloudy")
    expect(data[:data][:attributes][:forecast][:temperature]).to eq(61.2)
    expect(data[:data][:attributes][:activities][0][:"Sit in the dark and listen to your favorite music with no distractions"][:type]).to eq("relaxation")
  end
end
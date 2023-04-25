require "rails_helper"

RSpec.describe WeatherFacade do 
  before :each do
    denver_five_day_forecast = File.read("spec/fixtures/denver_five_day_forecast.json")
    stub_request(:get, "http://api.weatherapi.com/forecast.json?39.74001,-104.99202&days=5")
      .to_return(status: 200, body: denver_five_day_forecast)

      denver = File.read("spec/fixtures/denver_location.json")
      stub_request(:get, "https://www.mapquestapi.com/address?location=Denver,%20CO")
        .to_return(status: 200, body: denver)
  end

  it "will return a weather forecast for a specific location" do 
    denver_forecast = WeatherFacade.get_weather("Denver, CO")

    expect(denver_forecast[:location][:name]).to eq("Denver")
    expect(denver_forecast[:forecast][:forecastday].count).to eq(5)
    expect(denver_forecast[:forecast][:forecastday][0][:date]).to eq("2023-04-24")
    expect(denver_forecast[:forecast][:forecastday][4][:date]).to eq("2023-04-28")
    expect(denver_forecast[:current][:condition][:text]).to eq("Partly cloudy")
  end
end
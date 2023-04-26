require "rails_helper"

RSpec.describe "Weather requests" do 
  before :each do
    denver_five_day_forecast = File.read("spec/fixtures/denver_five_day_forecast.json")
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&q=39.74001,-104.99202")
      .to_return(status: 200, body: denver_five_day_forecast)

    denver = File.read("spec/fixtures/denver_location.json")
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?location=Denver,CO")
      .to_return(status: 200, body: denver)
  end

  it "will return the weather forecast for a specific location" do
    get "/api/v1/forecast?location=Denver,CO"

    expect(response.status).to eq(200)
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data][:id]).to eq(nil)
    expect(data[:data][:attributes][:current_weather][:last_updated]).to eq("2023-04-24 14:30")
    expect(data[:data][:attributes][:current_weather][:temperature]).to eq(61.2)
    expect(data[:data][:attributes][:current_weather][:feels_like]).to eq(61.2)
    expect(data[:data][:attributes][:current_weather][:humidity]).to eq(20)
    expect(data[:data][:attributes][:current_weather][:uvi]).to eq(5.0)
    expect(data[:data][:attributes][:current_weather][:visibility]).to eq(9.0)
    expect(data[:data][:attributes][:current_weather][:condition]).to eq("Partly cloudy")
    expect(data[:data][:attributes][:current_weather][:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/116.png")

    expect(data[:data][:attributes][:daily_weather][0][:date]).to eq("2023-04-24")
    expect(data[:data][:attributes][:daily_weather][0][:sunrise]).to eq("06:10 AM")
    expect(data[:data][:attributes][:daily_weather][0][:sunset]).to eq("07:47 PM")
    expect(data[:data][:attributes][:daily_weather][0][:max_temp]).to eq(65.7)
    expect(data[:data][:attributes][:daily_weather][0][:min_temp]).to eq(42.4)
    expect(data[:data][:attributes][:daily_weather][0][:condition]).to eq("Patchy rain possible")
    expect(data[:data][:attributes][:daily_weather][0][:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/176.png")

    expect(data[:data][:attributes][:hourly_weather][0][:time]).to eq("00")
    expect(data[:data][:attributes][:hourly_weather][0][:temperature]).to eq(46.4)
    expect(data[:data][:attributes][:hourly_weather][0][:conditions]).to eq("Clear")
    expect(data[:data][:attributes][:hourly_weather][0][:icon]).to eq("//cdn.weatherapi.com/weather/64x64/night/113.png")

    expect(data[:location]).to eq(nil)
    expect(data[:data][:attributes][:daily_weather][0][:wind_mph]).to eq(nil)
    expect(data[:data][:attributes][:hourly_weather][0][:will_it_snow]).to eq(nil)
  end
end
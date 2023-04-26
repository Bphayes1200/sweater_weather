require "rails_helper"

RSpec.describe WeatherFacade do 
  before :each do
    denver_five_day_forecast = File.read("spec/fixtures/denver_five_day_forecast.json")
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&q=39.74001,-104.99202")
      .to_return(status: 200, body: denver_five_day_forecast)

    denver = File.read("spec/fixtures/denver_location.json")
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?location=Denver,%20CO")
      .to_return(status: 200, body: denver)

    denver_weather_specific_datetime = File.read("spec/fixtures/denver_weather_specific_date_time.json")
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?dt=2023-04-25&hour=22:00&q=39.74001,-104.99202")
    .to_return(status: 200, body: denver_weather_specific_datetime)
  end

  it "will return a weather forecast for a specific location" do 
    denver_forecast = WeatherFacade.get_weather("Denver, CO")

    expect(denver_forecast[:location][:name]).to eq("Denver")
    expect(denver_forecast[:forecast][:forecastday].count).to eq(5)
    expect(denver_forecast[:forecast][:forecastday][0][:date]).to eq("2023-04-24")
    expect(denver_forecast[:forecast][:forecastday][4][:date]).to eq("2023-04-28")
    expect(denver_forecast[:current][:condition][:text]).to eq("Partly cloudy")
  end

  it "will return a specific day and times weather, datetime, and condition" do 
    denver_lat_long = LocationService.get_latlong("Denver, CO")
    formatted_date = "2023-04-25"
    formatted_hour =  "22:00"

    datetime_weather = WeatherFacade.get_datetime_weather(denver_lat_long, formatted_date, formatted_hour)

    expect(datetime_weather[:datetime]).to eq("2023-04-25 22:00")
    expect(datetime_weather[:temperature]).to eq(42.8)
    expect(datetime_weather[:condition]).to eq("Overcast")
  end
end
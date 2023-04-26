require "rails_helper" 

RSpec.describe WeatherService do
  before :each do
    denver_five_day_forecast = File.read("spec/fixtures/denver_five_day_forecast.json")
    stub_request(:get, "http://api.weatherapi.com/forecast.json?39.74001,-104.99202&days=5")
      .to_return(status: 200, body: denver_five_day_forecast)

      denver = File.read("spec/fixtures/denver_location.json")
      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?location=Denver,%20CO")
      .to_return(status: 200, body: denver)
      
      denver_weather_specific_datetime = File.read("spec/fixtures/denver_weather_specific_date_time.json")
      stub_request(:get, "http://api.weatherapi.com/forecast.json?39.74001,-104.99202&dt=2023-04-25&hour=22:00")
      .to_return(status: 200, body: denver_weather_specific_datetime)
  end
  it "will get the forecast for a city for the next 5 days" do 
    denver_lat_long = LocationService.get_latlong("Denver, CO")
    denver_forecast = WeatherService.get_five_day_forecast_and_current(denver_lat_long[:lat], denver_lat_long[:lng])
  
    expect(denver_forecast[:forecast][:forecastday].count).to eq(5)
  end

  it "will get the weather for a specific day and time for a location" do 
    denver_lat_long = LocationService.get_latlong("Denver, CO")
    formatted_date = "2023-04-25"
    formatted_hour =  "22:00"

    denver_weather = WeatherService.get_specific_day_weather(denver_lat_long, formatted_date, formatted_hour)

    expect(denver_weather[:location][:name]).to eq("Denver")
    expect(denver_weather[:forecast][:forecastday][0][:date]).to eq("2023-04-25")
    expect(denver_weather[:forecast][:forecastday][0][:hour][0][:time]).to eq("2023-04-25 22:00")
  end
end
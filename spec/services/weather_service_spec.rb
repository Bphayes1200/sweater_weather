require "rails_helper" 

RSpec.describe WeatherService do
  before :each do
    denver_five_day_forecast = File.read("spec/fixtures/denver_five_day_forecast.json")
    stub_request(:get, "http://api.weatherapi.com/forecast.json?39.74001,-104.99202&days=5")
      .to_return(status: 200, body: denver_five_day_forecast)

      denver = File.read("spec/fixtures/denver_location.json")
      stub_request(:get, "https://www.mapquestapi.com/address?location=Denver,%20CO")
        .to_return(status: 200, body: denver)
  end
  it "will get the forecast for a city for the next 5 days" do 
    denver_lat_long = LocationService.get_latlong("Denver, CO")
    denver_forecast = WeatherService.get_five_day_forecast_and_current(denver_lat_long[:lat], denver_lat_long[:lng])
  
    expect(denver_forecast[:forecast][:forecastday].count).to eq(5)
  end
end
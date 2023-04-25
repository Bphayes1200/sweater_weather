require "rails_helper" 


RSpec.describe ActivitiesFacade do 
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

  it "will return two activities based on the weather" do 
    weather = WeatherFacade.get_weather("denver,co")
    activities = ActivitiesFacade.get_activities_by_weather(weather)
  

    expect(weather[:current][:temp_f]).to eq(61.2)
    expect(activities[:activities][0][:type]).to eq("relaxation")
    expect(activities[:activities][1][:type]).to eq("recreational")
  end
end
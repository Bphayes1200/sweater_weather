require "rails_helper"

RSpec.describe "Activities Request" do 
  it "will return a response with a destination, forecast, and two activities" do 

    get "/api/v1/activities?destination=chicago,il"

    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data][:id]).to eq(nil)
    expect(data[:data][:attributes][:destination]).to eq("chicago,il")
  end
end
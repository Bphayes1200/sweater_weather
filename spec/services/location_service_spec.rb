require "rails_helper" 

RSpec.describe LocationService do 
  before :each do
    denver = File.read("spec/fixtures/denver_location.json")
    stub_request(:get, "https://www.mapquestapi.com/address?location=Denver,%20CO")
      .to_return(status: 200, body: denver)
  end
  it "will return a locations lat and long" do 
    denver_lat_long = LocationService.get_latlong("Denver, CO")

    expect(denver_lat_long[:lat]).to eq(39.74001)
    expect(denver_lat_long[:lng]).to eq(-104.99202)
  end
end
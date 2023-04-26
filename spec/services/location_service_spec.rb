require "rails_helper" 

RSpec.describe LocationService do 
  before :each do
    denver = File.read("spec/fixtures/denver_location.json")
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?location=Denver,%20CO")
      .to_return(status: 200, body: denver)
    
      directions_den_to_slc = File.read("spec/fixtures/directions_from_denver_to_salt_lake.json")
      stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=Denver,CO&to=Salt%20Lake%20City,UT")
        .to_return(status: 200, body: directions_den_to_slc)
  end
  it "will return a locations lat and long" do 
    denver_lat_long = LocationService.get_latlong("Denver, CO")

    expect(denver_lat_long[:lat]).to eq(39.74001)
    expect(denver_lat_long[:lng]).to eq(-104.99202)
  end

  it "will return directiions data" do 
    directions = LocationService.get_directions("Denver,CO","Salt Lake City,UT")
  

    expect(directions[:route][:distance]).to eq(517.6345)
    expect(directions[:route][:time]).to eq(27626)
  end
end
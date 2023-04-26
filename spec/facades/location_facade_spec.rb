require "rails_helper"

RSpec.describe LocationFacade do
  before :each do 
    directions_den_to_slc = File.read("spec/fixtures/directions_from_denver_to_salt_lake.json")
    stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=Denver,Co&to=Salt%20Lake%20City,UT")
      .to_return(status: 200, body: directions_den_to_slc)
  end
  it "will return the time for a route" do 
    time = LocationFacade.get_route_time("Denver,Co", "Salt Lake City,UT")

    expect(time).to eq("07:40:26")
  end
end
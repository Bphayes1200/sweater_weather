require "rails_helper"

RSpec.describe TeleportService do 
  before :each do 
    chicago = File.read("spec/fixtures/chicago.json")
    stub_request(:get, "https://api.teleport.org/cities/?limit=1&search=Chicago")
    .to_return(status: 200, body: chicago)
  end
  it "will return a cities information" do 
    chicago = TeleportService.get_city("Chicago")
    
    expect(chicago[:_embedded][:"city:search-results"][0][:matching_full_name]).to eq("Chicago, Illinois, United States")
    expect(chicago[:_embedded][:"city:search-results"][0][:_links][:"city:item"][:href]).to eq("https://api.teleport.org/api/cities/geonameid:4887398/")
  end
end
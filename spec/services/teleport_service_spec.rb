require "rails_helper"

RSpec.describe TeleportService do 
  before :each do 
    chicago = File.read("spec/fixtures/chicago.json")
    stub_request(:get, "https://api.teleport.org/cities/?limit=1&search=Chicago")
    .to_return(status: 200, body: chicago)

    chicago_geoname_id = File.read("spec/fixtures/chicago_by_geonameid.json")
    stub_request(:get, "https://api.teleport.org/api/cities/geonameid:4887398/")
    .to_return(status: 200, body: chicago_geoname_id)

    chicago_jobs = File.read("spec/fixtures/chicago_salaries.json")
    stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:chicago/")
    .to_return(status: 200, body: chicago_jobs)
  end
  it "will return a cities information" do 
    chicago = TeleportService.get_city("Chicago")

    expect(chicago[:_embedded][:"city:search-results"][0][:matching_full_name]).to eq("Chicago, Illinois, United States")
    expect(chicago[:_embedded][:"city:search-results"][0][:_links][:"city:item"][:href]).to eq("https://api.teleport.org/api/cities/geonameid:4887398/")
  end

  it "will return a cities information by geonameid" do 
    chicago_by_geoid = TeleportService.get_city_by_id("Chicago")

    expect(chicago_by_geoid).to eq("https://api.teleport.org/api/urban_areas/slug:chicago/")
  end

  it "will return jobs and salary ranges" do 
    chicago_salaries = TeleportService.get_salaries("Chicago")
  
    expect(chicago_salaries[0][:salary_percentiles]).to eq({:percentile_25=>53732.4997858553, :percentile_50=>67273.75507905365, :percentile_75=>84227.57438186172})
  end
end
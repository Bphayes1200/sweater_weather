require "rails_helper"

RSpec.describe "salaries requests" do 
  before :each do 
    chicago = File.read("spec/fixtures/chicago.json")
    stub_request(:get, "https://api.teleport.org/cities/?limit=1&search=chicago")
    .to_return(status: 200, body: chicago)

    chicago_geoname_id = File.read("spec/fixtures/chicago_by_geonameid.json")
    stub_request(:get, "https://api.teleport.org/api/cities/geonameid:4887398/")
    .to_return(status: 200, body: chicago_geoname_id)

    chicago_jobs = File.read("spec/fixtures/chicago_salaries.json")
    stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:chicago/")
    .to_return(status: 200, body: chicago_jobs)
  end

  it "will return the salaries of a specific destination" do 
    get "/api/v1/salaries?destination=chicago"

  end
end
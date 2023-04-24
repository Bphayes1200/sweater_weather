require "rails_helper"

RSpec.describe "Weather requests" do 
  get "/api/v1/forecast?location=cincinatti,oh"
end
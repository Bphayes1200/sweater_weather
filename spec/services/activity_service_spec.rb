require "rails_helper"

RSpec.describe ActivityService do 
  before :each do 
    rec_activity = File.read("spec/fixtures/recreational_activity.json")
    stub_request(:get, "http://www.boredapi.com/activity?type=recreational")
      .to_return(status: 200, body: rec_activity)
  end

  it "will get different types of activities" do 
    activity = ActivityService.get_activity_by_type("recreational")

    expect(activity[:activity]).to eq("Patronize a local independent restaurant")
    expect(activity[:type]).to eq("recreational")
  end
end
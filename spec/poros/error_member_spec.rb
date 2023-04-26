require "rails_helper"

RSpec.describe ErrorMember do 
  it "will exist and have attributes" do 
    error = ErrorMember.new("Not Found", 404, "NOT FOUND")

    expect(error.error_message).to eq("Not Found")
    expect(error.status).to eq(404)
    expect(error.code).to eq("NOT FOUND")
  end
end
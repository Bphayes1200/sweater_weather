require "rails_helper"

RSpec.describe "User Requests" do 
  it "can create a new user" do
    user_data = { 
            "email": "whatever@example.com",
            "password": "password",
            "password_confirmation": "password"
            }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users", headers: headers , params: JSON.generate(user_data)
  
    user = User.last

    expect(response.status).to eq(201)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(user.email).to eq("whatever@example.com")
    expect(user.password_digest).to_not eq("password")
    expect(data[:data][:id]).to_not eq(nil)
    expect(data[:data][:attributes][:email]).to eq("whatever@example.com")
    expect(data[:data][:attributes][:password]).to eq(nil)
    expect(data[:data][:attributes][:api_key].length).to eq(32)
  end
end
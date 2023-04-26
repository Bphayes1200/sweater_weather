require "rails_helper"

RSpec.describe "session requests" do 
  it "can post a new session to the database" do 
    new_user_data = { 
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
      }

    new_user_headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users", headers: new_user_headers , params: JSON.generate(new_user_data)
    
    user_data = { 
      "email": "whatever@example.com",
      "password": "password",
      }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/sessions", headers: headers , params: JSON.generate(user_data)

    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data][:id]).to_not eq(nil)
    expect(data[:data][:attributes][:email]).to eq("whatever@example.com")
    expect(data[:data][:attributes][:password]).to eq(nil)
    expect(data[:data][:attributes][:api_key].length).to eq(32)
  end

  it "will not post if credentials are not the same" do 
    new_user_data = { 
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    new_user_headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users", headers: new_user_headers , params: JSON.generate(new_user_data)
    
    user_data = { 
      "email": "whatever@example.com",
      "password": "hi",
      }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/sessions", headers: headers , params: JSON.generate(user_data)

    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(data[:errors][0][:message]).to eq("Your username or password is incorrect")
  end
end
class UserSerializer
  include JSONAPI::Serializer

  set_type :users

  attributes :email
   
  attribute :api_key do |user| 
    user.api_keys[0][:access_token]
  end
end

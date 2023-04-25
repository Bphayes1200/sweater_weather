class ActivitySerializer
  include JSONAPI::Serializer
  
  set_type :activities
  set_id { nil }

  attribute :destination do |activites_and_weather|
    activites_and_weather[:weather][:location][:name]
  end

  attribute :forecast do |activites_and_weather|
    {
    summary: activites_and_weather[:weather][:current][:condition][:text],
    temperature: activites_and_weather[:weather][:current][:temp_f]
    }
  end

  attribute :activities do |activites_and_weather|
    activites_and_weather[:activities].map do |activity|
    {
      activity[:activity] => {
      type: activity[:type],
      participants: activity[:participants],
      price: activity[:price]
      }
    }
    end
  end
end

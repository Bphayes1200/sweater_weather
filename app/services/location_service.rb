class LocationService 
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_latlong(location)
    request = get_url("/address?location=#{location}")
    request[:results][0][:locations][0][:latLng]
  end

  private

  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/" ) do |faraday|
      faraday.headers["key"] = ENV["MAP_QUEST_API_KEY"]
    end
  end
end
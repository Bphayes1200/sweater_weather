class LocationService 
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_latlong(location)
    request = get_url("/geocoding/v1/address?location=#{location}")
    request[:results][0][:locations][0][:latLng]
  end

  def self.get_directions(from, to)
    get_url("/directions/v2/route?&from=#{from}&to=#{to}")
  end
  private

  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com" ) do |faraday|
      faraday.headers["key"] = ENV["MAP_QUEST_API_KEY"]
    end
  end
end
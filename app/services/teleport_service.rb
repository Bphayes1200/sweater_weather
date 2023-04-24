class TeleportService
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_city(city)
    get_url("/cities/?search=#{city}&limit=1")
  end

  def self.get_city_by_id(city)
    get_url(get_city(city)[:_embedded][:"city:search-results"][0][:_links][:"city:item"][:href])[:_links][:"city:urban_area"][:href]
  end

  def self.get_salaries(city)
    get_url(get_city_by_id(city))
  end
  private
  
  def self.conn 
    Faraday.new(url: "https://api.teleport.org/api" )
  end
end
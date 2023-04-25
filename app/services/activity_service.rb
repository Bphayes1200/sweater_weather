class ActivityService 
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_activity_by_type(activity)
    get_url("/activity?type=#{activity}")
  end

  private
  
  def self.conn 
    Faraday.new(url: "http://www.boredapi.com/api")
  end
end
class ActivitiesFacade 
  def self.get_activities_by_weather(weather)
    current_temp = weather[:current][:temp_f]
    activities = []
    if current_temp >= 60 
      activities << ActivityService.get_activity_by_type("relaxation")
      activities << ActivityService.get_activity_by_type("recreational")
    elsif current_temp >= 50 && current_temp < 60
      activities << ActivityService.get_activity_by_type("relaxation")
      activities << ActivityService.get_activity_by_type("busywork")
    elsif current_temp < 50 
      activities << ActivityService.get_activity_by_type("relaxation")
      activities << ActivityService.get_activity_by_type("cooking")
    end
    activities
  end
end
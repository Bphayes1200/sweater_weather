class Api::V1::ActivitiesController < ApplicationController
  def index
    weather = WeatherFacade.get_weather(params[:destination])
    activites_and_weather = ActivitiesFacade.get_activities_by_weather(weather)
    render json: ActivitySerializer.new(activites_and_weather)
  end
end
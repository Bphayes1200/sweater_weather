class Api::V1::ActivitiesController < ApplicationController
  def index
    weather = WeatherFacade.get_weather(params[:destination])
    activites = ActivitiesFacade.get_activites(weather)

  end
end
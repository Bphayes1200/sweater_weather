class ForecastController < ApplicationController
 def show
  weather = WeatherFacade.get_weather(params[:location])
  # render json: Weather
 end
end

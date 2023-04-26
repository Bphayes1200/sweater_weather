class Api::V1::RoadTripController < ApplicationController
  def create
    key = ApiKey.find_by(access_token: params[:api_key])
    if key
      RoadTripFacade.new(params[:origin], params[:destination])
    end
    require 'pry'; binding.pry
  end
end
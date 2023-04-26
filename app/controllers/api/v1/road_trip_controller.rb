class Api::V1::RoadTripController < ApplicationController
  def create
    key = ApiKey.find_by(access_token: params[:api_key])
    if key
      road_trip = RoadTripFacade.new(params[:origin], params[:destination])
      data = road_trip.get_road_trip
      render json: RoadTripSerializer.new(data)
    else
      error_member = ErrorMember.new("Unauthorized Request", 401, "Unauthorized")
      render json: ErrorMemberSerializer.new(error_member).serialized_json
    end
  end
end
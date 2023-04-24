class Api::V1::SalariesController < ApplicationController
  def search
     render json: TeleportService.get_salaries(params[:destination])
  end
end
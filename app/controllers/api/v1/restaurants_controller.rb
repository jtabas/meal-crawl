class Api::V1::ResturantsController < ApplicationController
  def index
    render json: Resturant.all
  end
end

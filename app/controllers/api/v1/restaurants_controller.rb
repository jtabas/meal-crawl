class Api::V1::RestaurantsController < ApplicationController
  def index
    make_api_call
    render json: Restaurant.all
  end

  def create
    Restaurant.find_or_create_by(params[:lat, :long])
  end

  private

  def make_api_call
    # binding.pry
    data = JSON.parse(RestClient.get "http://freegeoip.net/json/#{request.remote_ip}")
    binding.pry
    lat = data.latitude
    long = data.longitude
  end
end

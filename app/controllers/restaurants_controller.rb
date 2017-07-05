class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.sample
    # @hours = @restaurant.hours.split("\\n")
  end
end

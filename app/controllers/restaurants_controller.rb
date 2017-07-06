class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews
    @review = Review.new

    @rating = if (@restaurant.rating % 1).zero? then @restaurant.rating.to_i else @restaurant.rating.round(1) end
    @hours = @restaurant.hours.split("\\n")
  end
end

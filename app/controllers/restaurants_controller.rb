class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews
    @review = Review.new
    if @restaurant.rating
      if (@restaurant.rating % 1).zero?
        @rating = @restaurant.rating.to_i
      else
        @rating = @restaurant.rating.round(1)
      end
    end
    @hours = @restaurant.hours.split("\\n")
  end
end

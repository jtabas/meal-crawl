class ReviewsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.restaurant = @restaurant

    @review.user = current_user
    @new_restaurant_rating = @review.rating.to_f + @restaurant.rating.to_f
    @restaurant.reviews.each { |review| @new_restaurant_rating += review.rating }
    @total_reviews = @restaurant.reviews.size.to_f + 2
    @new_restaurant_rating /= @total_reviews

    @restaurant.update_attribute(:rating, @new_restaurant_rating)

    if @review.save
      # ReviewMailer.new_review(@review).deliver_now
      flash[:notice] = 'Review added successfully'
      redirect_to restaurant_path(@restaurant)
    else
      flash[:notice] = @review.errors.full_messages.to_sentence
      redirect_to restaurant_path(@restaurant)
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @review.update(review_params)
      flash[:notice] = "Review Successfully Updated"
      redirect_to restaurant_path(@restaurant)
    else
      flash[:notice] = @review.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @restaurant = @review.restaurant
    @review.destroy
    redirect_to restaurant_path(@restaurant)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body, :user)
  end
end

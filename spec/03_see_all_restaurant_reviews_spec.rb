require 'rails_helper'
feature 'Restaurant\'s Reviews Show' do
  let!(:user) { FactoryGirl.create(:user, email: "Something@gmail.com") }
  let!(:restaurant) { FactoryGirl.create(:restaurant, name: "Yumm") }
  let!(:review) { FactoryGirl.create(:review, rating: 1, restaurant: restaurant, user: user) }
  let!(:review_no_body) { FactoryGirl.create(:review, rating: 1, restaurant: restaurant, body: nil, user: user) }
  let!(:reviews_sans_body) { FactoryGirl.create(:review, rating: 2, restaurant: restaurant, body: '', user: user) }

  scenario 'User visits Restaurant path and sees all reviews' do
    visit restaurant_path(restaurant)
    expect(page).to have_content(review.rating)
    expect(page).to have_content(review.body)
    expect(page).to have_content("Rating: #{review_no_body.rating}")
    expect(page).to have_content("Rating: #{reviews_sans_body.rating}")
  end
end

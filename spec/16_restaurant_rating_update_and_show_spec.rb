require 'rails_helper'
feature 'user update a restaurant\'s rating' do
  let!(:restaurant) { FactoryGirl.create(:restaurant) }
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, email: 'email@email.com') }
  let!(:review) { FactoryGirl.create(:review, restaurant: restaurant, user: user1) }

  scenario 'User posts a new review which changes the rating' do
    sign_in_as(user2)
    visit restaurant_path(restaurant)
    fill_in 'Rating', with: 4
    click_button 'Create Review'
    expect(page).to have_content("Rating: 4")
  end
end

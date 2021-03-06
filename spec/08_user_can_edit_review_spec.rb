require 'rails_helper'
feature 'User can edit a review' do
  let!(:restaurant) { FactoryGirl.create(:restaurant, name: "I will Implore him to Do So") }
  let!(:review) { FactoryGirl.create(:review, restaurant: restaurant) }
  let!(:review2) { FactoryGirl.create(:review, restaurant: restaurant) }
  let!(:user) { review.user }

  scenario 'User can get to the edit feature' do
    sign_in_as(user)
    visit restaurant_path(restaurant)
    click_link('Edit Review', match: :first)

    expect(page).to have_field('Rating', with: 3)
    expect(page).to have_content(review.body)
    expect(page).to have_button('Update Review')
  end
end

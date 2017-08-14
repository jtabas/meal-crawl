require 'rails_helper'
feature 'User can edit their own review' do
  let!(:restaurant) { FactoryGirl.create(:restaurant, name: "The Curtain Rises") }
  let!(:review) { FactoryGirl.create(:review, restaurant: restaurant) }
  let!(:review2) { FactoryGirl.create(:review, restaurant: restaurant) }
  let!(:user) { review.user }
  let!(:user2) { user }
  scenario 'User successfully edits a review' do
    sign_in_as(user)
    visit restaurant_path(restaurant)

    click_link('Edit Review', match: :first)

    fill_in 'Rating', with: 4
    fill_in 'Your Review', with: "Actually it\'s better because now they have dinosaurs."
    click_button 'Update Review'
    save_and_open_page
    expect(page).to have_content('Rating: 3')
    expect(page).to have_content("Actually it\'s better because now they have dinosaurs.")
    expect(page).to have_content('Review Successfully Updated')
  end

  scenario 'User unsuccessfully edits a review' do
    sign_in_as(user)
    visit restaurant_path(restaurant)
    click_link('Edit Review', match: :first)

    fill_in 'Rating', with: ''
    fill_in 'Your Review', with: ''
    click_button 'Update Review'
    save_and_open_page
    expect(page).to_not have_content('Review Successfully Updated')
    expect(page).to have_content('Rating can\'t be blank, Rating is not a number, and Rating is not a valid numeric rating (Must be between 1-5)')
  end
end

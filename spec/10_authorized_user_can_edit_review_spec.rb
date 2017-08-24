require 'rails_helper'
feature 'Only authorized user can edit a review' do
  let!(:restaurant) { FactoryGirl.create(:restaurant, name: "IN Unifrom and Evening Dress") }
  let!(:review) { FactoryGirl.create(:review, restaurant: restaurant, user: user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, email: 'NotJohnSmith@gmail.com') }

  scenario 'User cannot edit a review if not signed in' do
    visit restaurant_path(restaurant)

    expect(page).to_not have_link('Edit Review')
  end

  scenario 'User can only edit a review that does belongs to that user' do
    sign_in_as(user)
    visit restaurant_path(restaurant)

    expect(page).to have_link('Edit Review')
  end

  scenario 'User cannot edit a review that does not belong to that user' do

    sign_in_as(user2)
    visit restaurant_path(restaurant)

    expect(page).to have_no_link('Edit Review')
  end
end

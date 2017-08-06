require 'rails_helper'
feature 'Only authorized user can destroy a review' do
  let!(:restaurant) { FactoryGirl.create(:restaurant, name: "That's a Name if Ever I Saw One") }
  let!(:review) { FactoryGirl.create(:review, restaurant: restaurant, user: user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, email: 'NotJohnSmith@gmail.com') }

  scenario 'User cannot destroy a review if not signed in' do
    visit restaurant_path(restaurant)

    expect(page).to_not have_link('Delete Review')
  end

  scenario 'User can only destroy a review that does belongs to that user' do
    sign_in_as(user)
    visit restaurant_path(restaurant)

    expect(page).to have_link('Delete Review')
  end

  scenario 'User cannot destroy a review that does not belong to that user' do

    sign_in_as(user2)
    visit restaurant_path(restaurant)

    expect(page).to have_no_link('Delete Review')
  end

  scenario 'User destroys review' do
    sign_in_as(user)
    visit restaurant_path(restaurant)
    click_link 'Delete Review'

    expect(Review.all).to be_empty
  end
end

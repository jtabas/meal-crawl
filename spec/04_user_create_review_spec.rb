require 'rails_helper'
xfeature 'Restaurant\'s Reviews Create' do
  let!(:user) { FactoryGirl.create(:user, email: 'firefly@aol.com') }
  let!(:restaurant) { FactoryGirl.create(:restaurant, name: "Please") }

  scenario 'User creates a review' do
    sign_in_as(user)
    visit restaurant_path(restaurant)
    fill_in 'Rating', with: 5
    fill_in 'Your Review', with: 'Awesome Restaurant!!!...JK'

    click_button 'Create Review'

    expect(page).to have_content(5)
    expect(page).to have_content('Awesome Restaurant!!!...JK')
  end

  scenario 'User tries to create a review with empty fields' do
    sign_in_as(user)
    visit restaurant_path(restaurant)
    fill_in 'Rating', with: ''
    fill_in 'Your Review', with: ''
    click_button 'Create Review'

    expect(page).to have_content('Rating can\'t be blank, Rating is not a number, and Rating is not a valid numeric rating (Must be between 1-5)')
  end
end

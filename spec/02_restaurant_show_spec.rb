require 'rails_helper'

feature 'Restaurant Show' do
  let!(:restaurant) { FactoryGirl.create(:restaurant, name: "evnewevwunerwpunrpnu") }

  scenario 'User visits Museum show page directly' do
    visit restaurant_path(restaurant)
    expect(page).to have_content restaurant.name
    expect(page).to have_content restaurant.hours
    expect(page).to have_content restaurant.address
    expect(page).to have_content restaurant.phone
    expect(page).to have_content restaurant.website
  end
end

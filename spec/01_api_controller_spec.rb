require 'rails_helper'

describe "Restaurant API", type: :request do
  it 'sends a list of restaurants' do
    FactoryGirl.create_list(:restaurant, 10)

    get '/api/v1/restaurants'
    json = JSON.parse(response.body)
    expect(response).to be_success
  end
end

class Api::V1::RestaurantsController < ApplicationController
  def index
    make_api_call
    render json: Restaurant.all
  end

  def show
  end

  def create
    Restaurant.find_or_create_by(params[lat, long])
  end

  private

  def make_api_call
    data = JSON.parse(RestClient.get "http://freegeoip.net/json/#{request.remote_ip}")
    lat = data["latitude"]
    long = data["longitude"]
    key = ENV['GOOGLE_API_KEY']

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=lat,long&radius=1800&type=restaurant&keyword=taco&key=#{key}",
    {:content_type => :json, :'Authorization' => ENV['GOOGLE_API_KEY'] }
    response = JSON.parse(response)
    response['results'].each do |result|
       places = RestClient.get "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{result['place_id']}&key=#{key}"
      places = JSON.parse(places)
      restaurant = places['result']

      zipcode = restaurant['formatted_address'].match(/\d{5}/)
      hours = nil
      if restaurant['opening_hours']
        hours = restaurant['opening_hours']['weekday_text'].join('\n')
      end
      Restaurant.create!(
        name: restaurant['name'],
        address: restaurant['formatted_address'],
        zipcode: zipcode,
        hours: hours,
        website: restaurant['website'],
        phone: restaurant['formatted_phone_number'],
        food_type: result['rating']
      )
    end
  end
end

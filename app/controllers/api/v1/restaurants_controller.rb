class Api::V1::RestaurantsController < ApplicationController
  def index
    make_api_call
    render json: @location.restaurants
  end

  def create
    Restaurant.find_or_create_by(params[lat, long])
  end

  private

  def make_api_call
    data = JSON.parse(RestClient.get "http://freegeoip.net/json/#{request.remote_ip}")
    lat = 39.99267
    long = -75.1415
    key = ENV['GOOGLE_API_KEY']

    @location = Location.find_or_create_by(lat: lat, long: long)

    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{long}&radius=1800&type=restaurant&keyword=taco&key=#{key}",
    {:content_type => :json, :'Authorization' => ENV['GOOGLE_API_KEY'] }
    response = JSON.parse(response)
    response['results'].each do |result|
      places = RestClient.get "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{result['place_id']}&key=#{key}"
      places = JSON.parse(places)
      restaurant = places['result']
      zipcode = result['vicinity']
      hours = nil
      if result['opening_hours']
        hours = result['opening_hours']['weekday_text'].join('\n')
      end
      photo = nil
      if restaurant['photos']
        photo = "https://maps.googleapis.com/maps/api/place/photo?width=300,height=300&photoreference=#{restaurant['photos'].first['photo_reference']}&key=#{ENV['GOOGLE_API_KEY']}"
      end

      @restuarant = Restaurant.find_or_create_by(
        name: result['name'],
        address: result['vicinity'],
        zipcode: zipcode,
        food_type: result['name'],
        hours: hours,
        website: result['website'],
        photo: photo,
      )
      LocationsRestaurant.find_or_create_by(location: @location, restaurant: @restuarant)
    end
  end
end

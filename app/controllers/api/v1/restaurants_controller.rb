class Api::V1::RestaurantsController < ApplicationController
  def index
    make_api_call

    render json: @location.restaurants
  end

  def create
    Restaurant.find_or_create_by(params[lat: lat, long: long])
  end

  private

  def make_api_call
    data = JSON.parse(RestClient.get "http://freegeoip.net/json/96.227.251.212")
    lat = data["latitude"]
    long = data["longitude"]
    key = ENV['GOOGLE_API_KEY']

    @location = Location.find_or_create_by(lat: lat, long: long)
    response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{long}&radius=1800&type=restaurant&keyword=sushi&key=#{key}",
    {:content_type => :json, :'Authorization' => ENV['GOOGLE_API_KEY'] }
    response = JSON.parse(response)
    response['results'].each do |result|
      places = RestClient.get "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{result['place_id']}&key=#{key}"
      places = JSON.parse(places)
      restaurant = places['result']
      zipcode = 19145
      hours = nil
      photo = nil
      if restaurant['opening_hours']
        hours = restaurant['opening_hours']['weekday_text'].join('\n')
      end
      if restaurant['photos']
        photo = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{restaurant["photos"].first["photo_reference"]}&key=#{ENV['GOOGLE_API_KEY']}"
      end
      @restaurant = Restaurant.find_by(name: restaurant["name"], address: restaurant["formatted_address"])
        unless @restaurant
          @restaurant = Restaurant.create(
            name: restaurant["name"],
            address: restaurant["formatted_address"],
            zipcode: zipcode,
            food_type: restaurant["name"],
            hours: hours,
            website: restaurant['website'],
            photo: photo,
            rating: result['rating'],
            phone: restaurant["formatted_phone_number"]
          )
      end
      LocationsRestaurant.find_or_create_by(location: @location, restaurant: @restaurant)
    end
  end
end

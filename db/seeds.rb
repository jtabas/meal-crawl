require 'dotenv-rails'
require 'rest-client'

Restaurant.destroy_all
User.destroy_all
key = ENV['GOOGLE_API_KEY']

response = RestClient.get "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.9524,-75.1636&radius=1800&type=restaurant&keyword=taco&key=#{key}",
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

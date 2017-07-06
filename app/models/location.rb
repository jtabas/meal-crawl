class Location < ApplicationRecord
  has_many :locations_restaurants
  has_many :restaurants, through: :locations_restaurants
end

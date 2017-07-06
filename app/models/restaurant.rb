class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :locations_restaurants
  # has_many :locations, through: :locations_restaurants

  validates :name, presence: true
  validates :address, presence: true
  validates :food_type, presence: true
  validates :zipcode, presence: true
end

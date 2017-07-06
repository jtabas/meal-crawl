class Restaurant < ApplicationRecord
  has_many :reviews
  validates :name, presence: true
  validates :address, presence: true
  validates :food_type, presence: true
  validates :zipcode, presence: true
end

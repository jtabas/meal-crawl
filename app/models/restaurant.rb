class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :type, presence: true
  validates :zipcode, presence: true
end

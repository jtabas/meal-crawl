class Review < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :rating,
  presence: true,
  numericality: true,
  format: {
    with: /\A[1-5]\z/,
    message: ' is not a valid numeric rating (Must be between 1-5)'
  }
end

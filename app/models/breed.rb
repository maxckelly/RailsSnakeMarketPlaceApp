class Breed < ApplicationRecord
  has_many :listings
  
  validates :name, presence: { message: "%{value} must be filled in"}
end

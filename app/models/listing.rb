class Listing < ApplicationRecord
  belongs_to :breed
  enum sex: {female: 0, male: 1}

  # Validations 
  validates :title, :description, :sex, :price, :breed, presence: true # This is saying that we require all the fields to be entered
  validates :state, format: { with: /[1-9][0-9][0-9][0-9]/, message: "Only allows 4 numbers" }
  validates :state, inclusion: { in: %w(VIC NSW WA NT ACT QLD SA), message: "%{value} is not valid state" }
  validates :deposit, numericality: { less_than_or_equal_to: :price, message: "can't be greater than price" } 
end

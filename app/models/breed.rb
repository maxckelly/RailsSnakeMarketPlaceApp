class Breed < ApplicationRecord
  # The below deletes the data, plus all the data assigned to it. Because listing is dependant on the breed once the breed has been deleted it will delete the listings attached to it. You can also null the listings by doing `has_many :listings, dependent: :destory`
  has_many :listings, dependent: :destroy
  validates :name, presence: { message: "%{value} must be filled in"}
end

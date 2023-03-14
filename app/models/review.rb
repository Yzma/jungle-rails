class Review < ApplicationRecord

  belongs_to :user
  belongs_to :product

  # TODO: Refer back to step 2, should a review still be valid as long as a rating or a description is present?
  validates :product, presence: true
  validates :user, presence: true
  validates :description, presence: true
  validates :rating, presence: true

end

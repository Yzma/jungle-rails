class Review < ApplicationRecord

  belongs_to :user
  belongs_to :product

  # TODO: Refer back to step 2, should a review still be valid as long as a rating or a description is present?
  validates :product, presence: true
  validates :user, presence: true
  validates :description, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

end

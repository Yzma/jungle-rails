class Review < ApplicationRecord

  # create_table "reviews", force: :cascade do |t|
  #   t.integer "product_id"
  #   t.integer "user_id"
  #   t.text "description"
  #   t.integer "rating"
  #   t.datetime "created_at", precision: 6, null: false
  #   t.datetime "updated_at", precision: 6, null: false
  # end

  belongs_to :user
  belongs_to :product

  # TODO: Refer back to step 2, should a review still be valid as long as a rating or a description is present?
  validates :product, presence: true
  validates :user, presence: true
  validates :description, presence: true
  validates :rating, presence: true

end

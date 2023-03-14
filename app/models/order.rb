class Order < ApplicationRecord
  
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :decrease_item_quantities

  def decrease_item_quantities
    # Use a hash here to batch update the products instead of updating them 1 by 1
    hash = { } # :id => { quantity: 5 }

    self.line_items.each do |line_item|
      hash[line_item.product_id] = { quantity: line_item.product.quantity - line_item.quantity }
    end

    Product.update(hash.keys, hash.values)
  end

end

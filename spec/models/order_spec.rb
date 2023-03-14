require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do

      @cat = Category.find_or_create_by! name: 'Evergreens'

      @product1 = @cat.products.create!({
        name:  'Giant Tea 1',
        description: "Description 1",
        image: "image_url",
        quantity: 5,
        price: 10.00
      })

      @product2 = @cat.products.create!({
        name:  'Scented Blade',
        description: "Description 2",
        image: "image_url",
        quantity: 10,
        price: 15.00
      })

      @product3 = @cat.products.create!({
        name:  'Lion Grapevine',
        description: "Description 3",
        image: "image_url",
        quantity: 15,
        price: 20.00
      })
      
      # Products 1 and 2 will only be in the cart, we leave product 3 out to test that it won't affect the quantity count of other products not in the order
      @products = [@product1, @product2]

      # The amount of itmes that will be in each line item in the order
      @quantity = 2

      # Calculate the total cost that will be a placeholder in the order
      @total_cents = 0
      @products.each { |x| @total_cents += x.price_cents *  @quantity }

      @order = Order.new(
        email: "test@test.com",
        total_cents: @total_cents,
        stripe_charge_id: "stripe_id_here"
      )

      @products.each do |product|
        @order.line_items.new(
          product: product,
          quantity: @quantity,
          item_price: product.price_cents,
          total_price: product.price_cents * @quantity
        )
      end

      @order.save!

      # Reload each product so we can get an updated count in the tests
      @products.each do |product|
        product.reload
      end

    end
   
    it 'deducts quantity from products based on their line item quantities' do
      expect(@product1.quantity).to equal(3)
      expect(@product2.quantity).to equal(8)
    end

    it 'does not deduct quantity from products that are not in the order' do
      expect(@product1.quantity).to equal(3)
      expect(@product2.quantity).to equal(8)
      expect(@product3.quantity).to equal(15)
    end
  end
end

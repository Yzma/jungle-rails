require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      date = 5.days.ago
      @valid_category = Category.new(name: "Category name", created_at: date, updated_at: date)
    end

    describe "a valid product" do
      it "should save successfully" do
        @product = Product.new(name: "Test Name", price_cents: 5800, quantity: 54, category: @valid_category)
        expect(@product).to be_valid
        expect(@product.errors).to be_empty
      end
    end

    describe ":name" do
      it "should not be valid" do
        @product = Product.new(name: nil, price_cents: 5800, quantity: 54, category: @valid_category)
        expect(@product).to_not be_valid
        expect(@product.errors).to_not be_empty
      end
    end

    describe ":price" do
      it "should not be valid" do
        @product = Product.new(name: "Test Name", price_cents: nil, quantity: 54, category: @valid_category)
        expect(@product).to_not be_valid
        expect(@product.errors).to_not be_empty
      end
    end

    describe ":quantity" do
      it "should not be valid" do
        @product = Product.new(name: "Test Name", price_cents: 5800, quantity: nil, category: @valid_category)
        expect(@product).to_not be_valid
        expect(@product.errors).to_not be_empty
      end
    end

    describe ":category" do
      it "should not be valid" do
        @product = Product.new(name: "Test Name", price_cents: 5800, quantity: 54, category: nil)
        expect(@product).to_not be_valid
        expect(@product.errors).to_not be_empty
      end
    end

  end
end
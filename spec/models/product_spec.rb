require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      date = 5.days.ago
      @valid_category = Category.new(name: "Category name", created_at: date, updated_at: date)
    end

    describe "a valid product" do
      it "should save successfully" do
        @valid_product = Product.new(name: "Test Name", price_cents: 5800, quantity: 54, category: @valid_category)
        expect(@valid_product).to be_valid
      end
    end

    describe ":name" do
      it "should not be valid" do
        @valid_product = Product.new(name: nil, price_cents: 5800, quantity: 54, category: @valid_category)
        expect(@valid_product).to_not be_valid
      end
    end

    describe ":price" do
      it "should not be valid" do
        @valid_product = Product.new(name: "Test Name", price_cents: nil, quantity: 54, category: @valid_category)
        expect(@valid_product).to_not be_valid
      end
    end

    describe ":quantity" do
      it "should not be valid" do
        @valid_product = Product.new(name: "Test Name", price_cents: 5800, quantity: nil, category: @valid_category)
        expect(@valid_product).to_not be_valid
      end
    end

    describe ":category" do
      it "should not be valid" do
        @valid_product = Product.new(name: "Test Name", price_cents: 5800, quantity: 54, category: nil)
        expect(@valid_product).to_not be_valid
      end
    end

  end
end
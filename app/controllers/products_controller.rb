class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @current_reviews = @product.reviews.order(created_at: :desc)
    @review = Review.new
  end

end

class ReviewsController < ApplicationController

  before_action :authorize
  before_action :check_null_product_and_return

  def check_null_product_and_return
    @product = Product.find_by(id: params[:product_id])
    if @product.blank?
      return redirect_to '/products'
    end
  end

  def create

    review = @product.reviews.new(review_params)
    review.user = current_user

    if review.save
      redirect_to @product
    else
      # TODO: Route somewhere else?
      raise "This wasn't supposed to happen"
    end
  end

  def destroy
    @review = Review.find_by(id: params[:review_id])
    if @review.blank?
      return redirect_to @product
    end

    if(@review.user.id == current_user.id && @review.destroy)
      redirect_to @product
    else
      raise "Not correct user?"
    end

  end

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

end

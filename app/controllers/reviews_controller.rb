class ReviewsController < ApplicationController

  before_action :authorize

  def create
    if current_user
      product = Product.find_by(id: params[:product_id])

      review = product.reviews.new(review_params)
      review.user = current_user

      if review.save
        redirect_to "/products/#{params[:product_id]}"
      else
        # TODO: Route somewhere else?
        raise "This wasn't supposed to happen"
      end
      
    else

      redirect_to "/products/#{params[:product_id]}"
    end
  end

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

end

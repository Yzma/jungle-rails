class OrderMailer < ApplicationMailer
  default from: 'orders@junglebook.com'

  def order_confirmation
    @order = params[:order]
    mail(to: @order.email, subject: "Order Confirmation (#{@order.id})")
  end
end

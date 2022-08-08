class CheckoutController < ApplicationController
  def create
    @session = Stripe::Checkout::Session.create({
                                       success_url: pricing_url,
                                       cancel_url: posts_url,
                                       line_items: [
                                         { price: 'price_1LUF8cLmMqCJ6TiKtnaTYGqY', quantity: 1 }
                                       ],
                                       payment_method_types: [
                                         'card'
                                       ],
                                       mode: 'subscription'
                                     })  
                                                              
    redirect_to @session.url, allow_other_host: true

    rescue Stripe::InvalidRequestError => error
    # redirect back to your shopping cart or previous URL here if there's an error
    redirect_to pricing_url, alert: error.message 
  end
end

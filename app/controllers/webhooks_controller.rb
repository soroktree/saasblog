class WebhooksController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def create
        payload = request.body.read 
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
        event = nil 

        begin
            event = Stripe::Webhook.construct_event(
                payload, sig_header, Rails.application.credentials.dig(:stripe, :webhook)
            )
        rescue JSON::ParserError => e
            status 400
            return
        rescue Stripe::SignatureVerificationError => e
           puts "Signature error"
           p e 
           return
        end
        
        case event.type
        when 'checkout.session.completed'
                session = event.data.object
                @user = User.find_by(stripe_customer_id: session.customer)
                @user.update(subscription_status: 'active')
        when 'customer.subscription.updated', 'customer.subscription.deleted'
                subcription = event.data.object
                @user = User.find_by(stripe_customer_id: subscription.customer)
                @user.update(
                    subcription_status: subcription.status,
                    plan: subcription.items.data[0].price.lookup_key
                )
        end 
        render json: {message: 'success'}
    end
end
class BillingPortalController < ApplicationController
    def create
        @portal_session = Stripe::BillingPortal::Session.create({
            customer: current_user.stripe_customer_id,
            return_url: root_url
        })
        
        redirect_to @portal_session.url, allow_other_host: true

        rescue Stripe::InvalidRequestError => error
        # redirect back to your shopping cart or previous URL here if there's an error
            redirect_to root_url, alert: error.message 
    end
end
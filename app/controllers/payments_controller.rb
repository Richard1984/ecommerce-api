class PaymentsController < ApplicationController
    Stripe.api_key = Rails.application.credentials.stripe_secret_key
    
    def show
        products = Cart.where(user_id: current_user.id)
		user_cart = products.map { |p|
			{ 
				:product => Product.where(id:p[:product_id]).first,
                :quantity => p[:quantity]
			}
		}
        # amount is the sum of all the products in the cart
        amount = user_cart.map { |p| p[:product][:price] * p[:quantity] }.sum
        # Create a PaymentIntent with amount and currency
        payment_intent = Stripe::PaymentIntent.create(
            amount: (amount*100).to_i,
            currency: 'eur',
            automatic_payment_methods: {
            enabled: true,
            },
        )
        render json: { client_secret: payment_intent['client_secret'], cart: user_cart }
    end

    def success
        # Verify the event by fetching it from Stripe
        event = Stripe::Webhook.construct_event(
            request.body.read,
            request.headers['stripe-signature'],
            Rails.application.credentials.stripe_webhook_secret
        )
        # Handle the event
        case event['type']
        when 'payment_intent.succeeded'
            # The payment was successful, so update the cart
            user_id = event['data']['object']['metadata']['user_id']
            user_cart = Cart.where(user_id: user_id, filled:false)
            user_cart.each do |product|
                product.update_columns(filled:true)
            end
        when 'payment_intent.payment_failed'
            # The payment failed, so update the cart
            user_id = event['data']['object']['metadata']['user_id']
            user_cart = Cart.where(user_id: user_id, filled:false)
            user_cart.each do |product|
                product.update_columns(filled:false)
            end
        end
        render json: { message: "Webhook received." }
    end
end

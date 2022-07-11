class PaymentsController < ApplicationController
    Stripe.api_key = Rails.application.credentials.stripe_secret_key
    
    def create_order
        user_id = params[:user_id]
        # user_cart = Cart.where(user_id: user_id, filled:false)
        # sample data test
        user_cart = [
            {
                id: 1,
                name: "Product 1",
                price: 10.25,
                quantity: 1
            },
            {
                id: 2,
                name: "Product 2",
                price: 20,
                quantity: 2
            }
        ]
        # amount is the sum of all the products in the cart
        amount = user_cart.map { |product| product[:price] * product[:quantity] }.sum
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

class PaymentsController < ApplicationController
    Stripe.api_key = Rails.application.credentials.stripe_secret_key
    
    def show
        products = Cart.where(user_id: current_user.id)
        # Return if empty
        if products.empty?
            render json: { message: "Cart is empty" }, status: :not_acceptable
        end
		user_cart = products.map { |p|
			{ 
				:product => Product.where(id:p[:product_id]).first,
                :quantity => p[:quantity]
			}
		}

        # Create order with products in cart
		order = Order.new(
            user_id: current_user.id,
            payment_status: :paid_not,
            shipping_status: :shipped_not
        )
        # Save the order
		Order.transaction do
            order.save!
            OrderProduct.transaction do
                user_cart.each do |p|
                    prod = Product.find_by(id: p[:product][:id])
                    # av = prod[:availability] - p[:quantity]
                    # if av<0
                    #     raise StandardError.new("Not enough products")
                    # else 
                    #     prod.update_columns(availability:av)
                    op = OrderProduct.new(order_id: order[:id],product_id: p[:product][:id], quantity: p[:quantity])
                    op.save!
                    # end
                end
			end
        end

        # Amount is the sum of all the products in the cart
        amount = user_cart.map { |p| p[:product][:price] * p[:quantity] }.sum
        # Create a PaymentIntent with amount and currency
        payment_intent = Stripe::PaymentIntent.create(
            amount: (amount*100).to_i,
            currency: 'eur',
            setup_future_usage: 'on_session',
            metadata: {
                user_id: current_user.id,
                order_id: order.id
            },
            payment_method_types: ['card'] # We only accept cards
        )
        payment_methods = Stripe::Customer.list_payment_methods(
            current_user[:stripe_customer],
            {type: 'card'},
        )
        render json: {
            data: {
                payment_intent_id: payment_intent[:id],
                client_secret: payment_intent[:client_secret],
                cart: user_cart,
                order_id: order[:id],
                payment_methods: payment_methods[:data]
            }
        }, status: :ok
    end
    

    def save_payment_method
        if params[:save_payment_method] == "false"
            # Change PaymentIntent to not save payment method
            # params[:payment_intent_id]
        else
            # Change PaymentIntent to save payment method
            # params[:payment_intent_id]
        end
    end

    def success_client
        # Update payment state
		Order.transaction do
            # Get the order
            order = Order.where(user_id: current_user.id, id: params[:order_id], payment_status: :paid_not).first
            if order
                # Change the payment state
                order.update_columns(payment_status: :paid_client)
                # Save it
                order.save!
            else
                order = Order.where(user_id: current_user.id, id: params[:order_id]).first
                if order
                    # The order is already paid_client or paid
                    render json: { message: "Already done" }, status: :ok
                else
                    render json: { message: "Order not found" }, status: :not_acceptable
                end
            end
            render json: { message: "Order not found" }, status: :ok
        end
        # Empty the cart
        Cart.where(user_id: current_user.id).destroy_all
    end


    def success_webhook
        # Verify the event by fetching it from Stripe
        event = Stripe::Webhook.construct_event(
            request.body.read,
            request.headers['stripe-signature'],
            # if development, use stripe_webhook_secret instead of stripe_webhook_production_secret
            Rails.env.production? ? Rails.application.credentials.stripe_webhook_production_secret : Rails.application.credentials.stripe_webhook_secret
        )
        # Handle the event
        case event['type']
        when 'payment_intent.succeeded'
            # The payment was successful, so update the cart
            user_id = event['data']['object']['metadata']['user_id']
            order_id = event['data']['object']['metadata']['order_id']
            payment_intent_id = event['data']['object']['id']
            receipt_url = event['data']['object']['charges']['data'][0]['receipt_url']
            shipping = event['data']['object']['charges']['data'][0]['shipping']
            name = shipping['name']
            city = shipping['address']['city']
            country = shipping['address']['country']
            line1 = shipping['address']['line1']
            line2 = shipping['address']['line2']
            postal_code = shipping['address']['postal_code']
            Order.transaction do
                order = Order.where(user_id: user_id, id: order_id).first
                if order
                    order.update_columns(
                        payment_status: :paid,
                        payment_intent_id: payment_intent_id,
                        receipt_url: receipt_url,
                        name: name,
                        city: city,
                        country: country,
                        line1: line1,
                        line2: line2,
                        postal_code: postal_code
                    )
                    order.save!
                end
            end
        when 'payment_intent.payment_failed'
            # The payment failed, so update the cart
            user_id = event['data']['object']['metadata']['user_id']
            order_id = event['data']['object']['metadata']['order_id']
            Order.transaction do
                order = Order.where(user_id: user_id, id: order_id).first
                if order
                    order.update_columns(payment_status: :failed, payment_intent_id: event['data']['object']['id'])
                    order.save!
                end
            end
        end
        render json: { message: "Webhook received." }
    end
end

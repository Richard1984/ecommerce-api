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
        # Amount is the sum of all the products in the cart
        amount = user_cart.map { |p| p[:product][:price] * p[:quantity] }.sum
        # Create a PaymentIntent with amount and currency
        payment_intent = Stripe::PaymentIntent.create(
            amount: (amount*100).to_i,
            currency: 'eur',
            automatic_payment_methods: {
            enabled: true,
            },
        )

        # Create order with products in cart
		order = Order.new(
            user_id: current_user.id,
            payment_intent_id: payment_intent.id,
            payment_status: :not_paid,
            shipping_status: :not_shipped
        )
		Order.transaction do
            order.save!
            OrderProduct.transaction do
                products.each do |p|
                    prod = Product.find_by(id: p[:product_id])
                    # av = prod[:availability] - p[:quantity]
                    # if av<0
                    #     raise StandardError.new("Not enough products")
                    # else 
                    #     prod.update_columns(availability:av)
                    op = OrderProduct.new(order_id: order[:id],product_id: p[:product_id],quantity: p[:quantity])
                    op.save!
                    # end
                end
			end
        end
        render json: { client_secret: payment_intent['client_secret'], cart: user_cart, order_id: order[:id] }, status: :ok
    end

    def success_client
        # Update payment state
		Order.transaction do
            # Get the order
            order = Order.where(user_id: current_user.id, id: params[:order_id], payment_status: :not_paid).first
            if order
                # Change the payment state
                order.update_columns(payment_status: :paid_client)
                # Save it
                order.save!
            else
                order = Order.where(user_id: current_user.id, id: params[:order_id]).first
                if order
                    # The order is already paid_client or paid
                    render json: { message: "Already confirmed" }, status: :ok
                else
                    render json: { message: "Order not found" }, status: :not_acceptable
                end
            end
            render json: { message: "Order not found" }, status: :ok
        end
    end


    # def success_webhook
    #     # Verify the event by fetching it from Stripe
    #     event = Stripe::Webhook.construct_event(
    #         request.body.read,
    #         request.headers['stripe-signature'],
    #         Rails.application.credentials.stripe_webhook_secret
    #     )
    #     # Handle the event
    #     case event['type']
    #     when 'payment_intent.succeeded'
    #         # The payment was successful, so update the cart
    #         user_id = event['data']['object']['metadata']['user_id']
    #         user_cart = Cart.where(user_id: user_id, filled:false)
    #         user_cart.each do |product|
    #             product.update_columns(filled:true)
    #         end
    #     when 'payment_intent.payment_failed'
    #         # The payment failed, so update the cart
    #         user_id = event['data']['object']['metadata']['user_id']
    #         user_cart = Cart.where(user_id: user_id, filled:false)
    #         user_cart.each do |product|
    #             product.update_columns(filled:false)
    #         end
    #     end
    #     render json: { message: "Webhook received." }
    # end
end

class PaymentMethodsController < ApplicationController
    Stripe.api_key = Rails.application.credentials.stripe_secret_key
    
    def show
        payment_methods = Stripe::Customer.list_payment_methods(
            current_user[:stripe_customer],
            {type: 'card'},
        )

        render json: {
            data: payment_methods[:data]
        }, status: :ok
    end

    def remove_payment_method
        payment_method = Stripe::PaymentMethod.detach(
            params[:payment_method_id],
        )
        render json: {
            message: "Successfully removed payment method"
        }, status: :ok
    end

    def setup_new_payment_method
        setup_intent = Stripe::SetupIntent.create(
            customer: current_user[:stripe_customer],
            payment_method_types: ['card'],
          )
        render json: {
            data: setup_intent[:client_secret]
        }, status: :ok
    end

end

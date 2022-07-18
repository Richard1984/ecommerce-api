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

    def add_payment_method
        payment_method = Stripe::PaymentMethod.attach(
            params[:payment_method_id],
            {customer: current_user[:stripe_customer]},
        )
        render json: {
            data: payment_method
        }, status: :ok
    end

end

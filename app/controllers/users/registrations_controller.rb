class Users::RegistrationsController < Devise::RegistrationsController
  Stripe.api_key = Rails.application.credentials.stripe_secret_key
  respond_to :json
  
  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      # Create customer in Stripe and store it in the database
      customer = Stripe::Customer.create(
        email: resource.email
      )
      resource.update_columns(stripe_customer: customer[:id])
      render json: { message: 'Signed up.' }, status: :ok
    else
      render json: { message: "Could not sign up", data: resource.errors }, status: :bad_request
    end
  end
end
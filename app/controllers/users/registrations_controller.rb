class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  
  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { message: 'Signed up.' }, status: :ok
    else
      render json: { message: "Could not sign up", data: resource.errors }, status: :bad_request
    end
  end
end
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    current_user_json = JSON.parse(@user.to_json)
		current_user_json[:avatar] = @user.avatar.attached? ? url_for(@user.avatar) : nil
		current_user_json[:roles] = @user.roles
    render json: { data: current_user_jsons, message: 'Logged in.' }, status: :ok
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: "Logout effettuato.", data: current_user }, status: :ok
  end

  def log_out_failure
    render json: { message: "Couldn't find an active session." }, status: :unauthorized
  end
end
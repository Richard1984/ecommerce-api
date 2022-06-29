class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    # Da ricontrollare, il login sembra andare a buon fine, ma le altre funzioni sembrano non ricordarsi dell'utente (mentre dopo il signup se ne ricordano)
    render json: { data: @user, message: 'Logged in.' }, status: :ok
  end

  def respond_to_on_destroy
    current_user ? log_out_failure : log_out_success
  end

  def log_out_success
    render json: { message: "Logged out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Logged out failure.", data: current_user }, status: :unauthorized
  end
end
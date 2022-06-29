class ApplicationController < ActionController::API

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password)}

        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :email, :password, :current_password)}
    end



    # # Prevent CSRF attacks by raising an exception.
    # # For APIs, you may want to use :null_session instead.
    # # protect_from_forgery with: :null_session
    
    # include ActionController::HttpAuthentication::Basic::ControllerMethods
    # include ActionController::HttpAuthentication::Token::ControllerMethods
    # include ActionController::MimeResponds

    # respond_to :json

    # # before_action :underscore_params!
    # before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :authenticate_user

    # private

    # def configure_permitted_parameters
    #     devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    # end

    # def authenticate_user
    #     if request.headers['Authorization'].present?
    #         authenticate_or_request_with_http_token do |token|
    #             begin
    #                 puts JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!)
    #                 jwt_payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!)
                    
    #                 @current_user_id = jwt_payload['sub'].to_i
    #             rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    #                 head :unauthorized
    #             end
    #         end
    #     end
    # end

    # def authenticate_user!(options = {})
    #     head :unauthorized unless signed_in?
    # end

    # def current_user
    #     @current_user ||= super || User.find(@current_user_id)
    # end

    # def signed_in?
    #     @current_user_id.present?
    # end
end
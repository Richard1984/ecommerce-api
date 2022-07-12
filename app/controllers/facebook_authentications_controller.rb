class FacebookAuthenticationsController < ApplicationController
  respond_to :json

  def create
    facebook_access_token = params.require(:facebook_access_token)
    data = User.find_or_create_with_facebook_access_token(facebook_access_token)
    
    if data
      response.headers['Authorization'] = 'Bearer ' + data['token']
      render json: { data: data['user'] }, status: :ok
    else
      render json: { data: data.errors }, status: :unprocessable_entity
    end
  end
end
class FacebookAuthenticationsController < ApplicationController
  respond_to :json

  def create
    facebook_access_token = params.require(:facebook_access_token)
    data = User.find_or_create_with_facebook_access_token(facebook_access_token)
    
    if data
      response.headers['Authorization'] = 'Bearer ' + data['token']
      user = data['user']
      user_json = JSON.parse(user.to_json)
      user_json[:avatar] = url_for(user.avatar)
      user_json[:roles] = user.roles
      render json: { data: user_json }, status: :ok
    else
      render json: { data: data.errors }, status: :unprocessable_entity
    end
  end
end
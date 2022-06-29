class AccountController < ApplicationController

    before_action :authenticate_user!

	def index
		render json: { data: JSON.parse(current_user.to_json) }
	end
end
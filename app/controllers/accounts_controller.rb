class AccountsController < ApplicationController

    before_action :authenticate_user!

	def show
		render json: { data: current_user }
	end

	def edit
	end

	def update
		# si dovrebbe richiedere la password

		if current_user.update(params.require(:user).permit(:email, :name, :surname, :country)) # non so se accettare la mail qui crea problemi
			render json: { message: "User information was successfully updated.", data: current_user }, status: :ok
		else
			render json: { message: "Could not update user information", data: current_user.errors }, status: :not_acceptable
		end
	end
end
class AccountsController < ApplicationController

    before_action :authenticate_user!

	def show
		current_user_json = JSON.parse(current_user.to_json)
		current_user_json[:avatar] = user_avatar
		render json: { data: current_user_json }
	end

	def edit
	end

	def update
		# si dovrebbe richiedere la password

		if current_user.update(params.require(:user).permit(:email, :firstname, :lastname, :country)) # non so se accettare la mail qui crea problemi
			render json: { message: "User information was successfully updated.", data: current_user }, status: :ok
		else
			render json: { message: "Could not update user information", data: current_user.errors }, status: :not_acceptable
		end
	end

	def destroy
		# Eliminare l'utente elmina anche tutte le reviews e i voti alle reviews associati ad esso
		user = current_user
		sign_out user
		user.avatar.purge
		if user.destroy
			render json: { message: "User deleted.", data: user }, status: :ok
		else
			render json: { message: "Could not delete user", data: user.errors }, status: :internal_server_error
		end
	end

	def get_avatar
		if user_avatar
			render json: { data: user_avatar }, status: :ok
		else
			render json: { message: "User does not have an avatar" }, status: :not_found
		end
	end

	def update_avatar
		# Mettere qualche check per la dimensione, errori?
		current_user.avatar.attach(params[:avatar])
		render json: { message: "Avatar updated" }
	end

	def destroy_avatar
		current_user.avatar.purge
		render json: { message: "Avatar deleted" }
	end

	private
	
	def user_avatar
		return current_user.avatar.attached? ? url_for(current_user.avatar) : nil
	end
end
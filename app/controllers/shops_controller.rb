class ShopsController < ApplicationController
    # before_action :authenticate_user! #forza autenticazione

    def show
        render json: { data: Shop.instance}
    end

    def update
        if Shop.instance.update(params.require(:shop).permit(
            :name,
            :surname,
            :social_reason,
            :vat_number,
            :address,
            :sector
        ))
            render json: { message: "Shop information was successfully updated.", data: Shop.instance }, status: :ok
		else
			render json: { message: "Could not update shop information", data: Shop.instance.errors }, status: :not_acceptable
		end
    end
end
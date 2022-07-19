class ShopsController < ApplicationController
    # before_action :authenticate_user! #forza autenticazione

    def show
        authorize! :read, Shop, :message => "BEWARE: you are not authorized to read shop information."
        render json: { data: Shop.instance}
    end

    def update
        authorize! :update, Shop, :message => "BEWARE: you are not authorized to modify shop information."
        if Shop.instance.update(params.require(:shop).permit(
            :firstname,
            :lastname,
            :company_name,
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
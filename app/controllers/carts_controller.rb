class CartsController < ApplicationController
    #dubbio sul eliminare tutti i prodotti nel carello dopo l'ordine 
    def index
		# per il venditore si potrebbe far vedere tutti i carelli attivi
        products = Cart.where(user_id: current_user.id,filled:false)
		user_cart = products.map { |p|
			{ 
				:product => Product.where(id:p[:product_id]),
                :quantity => p[:quantity]
			}
		}	
		
        render json: { data: user_cart} 
    end

    def create
        p = Cart.find_by(user_id: current_user.id,product_id:params[:product_id],filled:false)
        if p
            quantity = params[:quantity] + p[:quantity]
            if  p.update_columns(quantity:quantity)
                render json: { message: "Product was successfully added to the cart.", data: p }, status: :ok
            else
                render json: { message: "Could not add the product", data: p.errors }, status: :not_acceptable
            end
        else
            product = Cart.new(user_id: current_user.id,product_id:params[:product_id],quantity:params[:quantity],filled:false)
            if product.save!
                render json: { message: "Product was successfully added to the cart.", data: product }, status: :ok
            else
                render json: { message: "Could not add the product", data: product.errors }, status: :not_acceptable
            end
        end
	end
    
    def destroy
        #con id si intende l'id del prodotto e non della cart
        product = Cart.find_by(user_id: current_user.id,product_id:params[:id],filled:false)
        if product
            if product.destroy
                render json: { message: "The product was successfully deleted from the cart.", data: product }, status: :ok
            else
                render json: { message: "Could not delete the product in the cart.", data: product.errors }, status: :not_acceptable
            end
        else
            render json: { message: "Couldn't find this product in the cart.", data: {product_id:params[:id]} }, status: :not_acceptable
        end
    end
end


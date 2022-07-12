class CartsController < ApplicationController
    #dubbio sul eliminare tutti i prodotti nel carello dopo l'ordine 
    def show
        authorize! :read, Cart, :message => "BEWARE: you do not have a cart, since you are not logged in."
		# per il venditore si potrebbe far vedere tutti i carelli attivi
        products = Cart.where(user_id: current_user.id)
		user_cart = products.map { |p|
			{ 
				:product => Product.where(id:p[:product_id]).first,
                :quantity => p[:quantity]
			}
		}	
		
        render json: { data: user_cart}, status: :ok
    end

    def update
        authorize! :update, Cart, :message => "BEWARE: you do not have a cart, since you are not logged in."
        availability = Product.find_by(id:params[:product_id])[:availability]
        case params[:op]
        when "create"
            p = Cart.find_by(user_id: current_user.id,product_id:params[:product_id])
            if p
                quantity = params[:quantity] + p[:quantity]
                if quantity > availability
                    render json: { message: "Could not add the product,add less", data: p.errors }, status: :not_acceptable
                else
                    if  p.update_columns(quantity:quantity)
                        render json: { message: "Product was successfully added to the cart.", data: p }, status: :ok
                    else
                        render json: { message: "Could not add the product", data: p.errors }, status: :not_acceptable
                    end
                end
            else
                if params[:quantity] > availability
                    render json: { message: "Could not add the product,add less", data: product }, status: :ok
                else
                    product = Cart.new(user_id: current_user.id,product_id:params[:product_id],quantity:params[:quantity])
                    if product.save!
                        render json: { message: "Product was successfully added to the cart.", data: product }, status: :ok
                    else
                        render json: { message: "Could not add the product", data: product.errors }, status: :not_acceptable
                    end
                end
            end
        when "update"
            if params[:quantity] > availability 
                render json: { message: "Could not add the product,add less", data: product }, status: :ok
            else
                p = Cart.find_by(user_id: current_user.id,product_id:params[:product_id])
                if  p.update_columns(quantity:params[:quantity])
                    render json: { message: "Product was successfully updated.", data: p }, status: :ok
                else
                    render json: { message: "Could not update the product", data: p.errors }, status: :not_acceptable
                end
            end

        when "remove"
            product = Cart.find_by(user_id: current_user.id,product_id:params[:product_id])
            if product
                if product.destroy
                    render json: { message: "The product was successfully deleted from the cart.", data: product }, status: :ok
                else
                    render json: { message: "Could not delete the product in the cart.", data: product.errors }, status: :not_acceptable
                end
            else
                render json: { message: "Couldn't find this product in the cart.", data: {product_id:params[:id]} }, status: :not_acceptable
            end
        else 
            render json: { message: "operation not available, enter a valid operation ['update','remove','create']"}, status: :not_acceptable
        end
    end

    def destroy
        if Cart.where(user_id: current_user.id).delete_all
            render json: { message: "the Cart was succesfully emptied."  }, status: :ok
        else
            render json: { message: "the Cart was not succesfully emptied."  }, status: :not_acceptable
        end
    end


end


class OrdersController < ApplicationController
    def index
		authorize! :read, Order, :message => "BEWARE: you are not authorized to read orders."
		if current_user.has_role? :admin
			orders = Order.all 
		else
        	orders = Order.where(user_id: current_user.id)
		end
		user_order = orders.map { |o|
			{ 
				:id => o.id, 
				:items => full_order(o)
			}
		}
        render json: { data: user_order} 
    end

	def show
		authorize! :read, Order, :message => "BEWARE: you are not authorized to read orders."
		if current_user.has_role? :admin 
			order = Order.find(params[:id])
		else
			order = Order.find_by(id: params[:id], user_id: current_user.id)
		end
		
        if order
			full_order_info = full_order(order)
            render json: { data: full_order_info}, status: :ok
        else
            render json: { message: "Order #{params[:id]} for user #{current_user.email} not found." }, status: :not_found
        end
	end
	
	
	def create
		authorize! :create, Order, :message => "BEWARE: you are not authorized to create orders."

		products = params[:products]
		order = Order.new(user_id: current_user.id)
		begin
			Order.transaction do
				order.save!
				OrderProduct.transaction do
					products.each do |p|
						prod = Product.find_by(id:p[:id])
						av = prod[:availability] - p[:quantity]
						if av<0
							raise StandardError.new("Not enough products")
						else
							prod.update_columns(availability:av)
							op = OrderProduct.new(order_id:order[:id],product_id:p[:id],quantity:p[:quantity])
							op.save!
						end
					end
				end
			end
		rescue Exception => e
            render json: { message: "Could not generate order", data: e }, status: 500
		else
			# Forse e' meglio passare tutto l'ordine e gli order_products
			render json: { message: "Order added.", data: order }, status: :ok
		end
	end
	def update
		
	end
end

private

def full_order(order)
	order.products.map{ |p|
		{
			:product => p,
			:quantity => OrderProduct.find_by(product_id: p[:id],order_id:order[:id])[:quantity]
		}
	}
end
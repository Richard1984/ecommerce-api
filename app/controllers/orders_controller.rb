class OrdersController < ApplicationController
    def index
		# Questo e' index per user corrente, index per negoziante da fare dopo con roles
		# if negoziante then orders = Order.all
        orders = Order.where(user_id: current_user.id)
		user_order = orders.map { |u|
			{ :id => u.id, :products => u.products.map{ |p|
					{
						:info => p,
						:quantity => OrderProduct.find_by(product_id: p[:id],order_id:u[:id])[:quantity]
					}
				} 
			}
		}	
		# Forse e' meglio passare tutto l'ordine e gli order_products
        render json: { data: user_order} 
    end

	def show
		# Questo e' show per user corrente, show per negoziante da fare dopo con roles
		# if negoziante then order = Order.find(params[:id])
		order = Order.find_by(id: params[:id], user_id: current_user.id)
        if order
			full_order_info = order.products.map{ |p|
				{
					:info => p,
					:quantity => OrderProduct.find_by(product_id: p[:id],order_id:order[:id])[:quantity]
				}
			}
            render json: { data: full_order_info}, status: :ok
        else
            render json: { message: "Order #{params[:id]} for user #{current_user.email} not found." }, status: :not_found
        end
	end
	
	def new
	end
	
	def create
		# DIMINUIRE AVAILABILITY DEI PRODOTTI ORDINATI? FARE CHECK DISPONIBILITA E IN CASO FARE ROLLBACK
		products = params[:products]
		order = Order.new(user_id: current_user.id)
		begin
			Order.transaction do
				order.save!
				OrderProduct.transaction do
					products.each do |p|
						op = OrderProduct.new(order_id:order[:id],product_id:p[:id],quantity:p[:quantity])
						op.save!
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
end

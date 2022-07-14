class OrdersController < ApplicationController	
    def index
		authorize! :read, Order, :message => "BEWARE: you are not authorized to read orders."
		if current_user.has_role? :admin
			orders = Order.all 
			user_order = orders.map { |o|
			{ 
				:id => o[:id], 
				:user_id => o[:user_id],
				:shipping_status => Order.shipping_statuses[o[:shipping_status]],
				:payment_status => Order.payment_statuses[o[:payment_status]],
				:items => full_order(o)
			}
		}
		else
			# Get orders paid (or paid_client), hide non completed orders
        	orders = Order.where(user_id: current_user.id, payment_status: [:paid, :paid_client])
			user_order = orders.map { |o|
			{ 
				:id => o[:id], 
				:shipping_status => Order.shipping_statuses[o[:shipping_status]],
				:payment_status => Order.payment_statuses[o[:payment_status]],
				:items => full_order(o)
			}
		}
		end
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
			render json: { data: {
				:id => params[:id],
				:shipping_status => Order.shipping_statuses[order[:shipping_status]],
				:payment_status => Order.payment_statuses[order[:payment_status]],
				:items => full_order(order),
				:receipt_url => ""
			}}, shipping_status: :ok
        else
            render json: { message: "Order #{params[:id]} for user #{current_user.email} not found." }, shipping_status: :not_found
        end
	end
	
	
	# def create
	# 	authorize! :create, Order, :message => "BEWARE: you are not authorized to create orders."

	# 	products = params[:products]
	# 	order = Order.new(user_id: current_user.id)
	# 	begin
	# 		Order.transaction do
	# 			order.save!
	# 			OrderProduct.transaction do
	# 				products.each do |p|
	# 					prod = Product.find_by(id:p[:id])
	# 					av = prod[:availability] - p[:quantity]
	# 					if av<0
	# 						raise StandardError.new("Not enough products")
	# 					else
	# 						prod.update_columns(availability:av)
	# 						op = OrderProduct.new(order_id:order[:id],product_id:p[:id],quantity:p[:quantity])
	# 						op.save!
	# 					end
	# 				end
	# 			end
	# 		end
	# 	rescue Exception => e
    #         render json: { message: "Could not generate order", data: e }, shipping_status: 500
	# 	else
	# 		# Forse e' meglio passare tutto l'ordine e gli order_products
	# 		render json: { message: "Order added.", data: order }, shipping_status: :ok
	# 	end
	# end


	def update_shipping
		authorize! :update, Order, :message => "BEWARE: you are not authorized to modify orders."
		case params[:op]
        when "next"
			order = Order.find_by(user_id: params[:id])
            if order
				shipping_status = order[:shipping_status] + 1
				if order.update_columns(shipping_status:shipping_status)
					render json: { message: "Shipping status correctly updated", data: order }, shipping_status: :ok
				else
					render json: { message: "Could not update the shipping status", data: order.errors }, shipping_status: :not_acceptable
				end
			else
				render json: { message:"Order #{params[:id]} for user #{current_user.email} not found.", data: order.errors }, shipping_status: :not_acceptable
			end
		when "previous"
			order = Order.find_by(user_id:params[:id])
            if order
				shipping_status = order[:shipping_status] - 1
				if order.update_columns(shipping_status:shipping_status)
					render json: { message: "Shipping status correctly updated", data: order }, shipping_status: :ok
				else
					render json: { message: "Could not update the shipping status", data: order.errors }, shipping_status: :not_acceptable
				end
			else
				render json: { message:"Order #{params[:id]} for user #{current_user.email} not found.", data: order.errors }, shipping_status: :not_acceptable
			end
		end

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
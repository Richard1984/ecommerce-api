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
			render json: {
					data: {
					:id => params[:id],
					:shipping_status => Order.shipping_statuses[order[:shipping_status]],
					:payment_status => Order.payment_statuses[order[:payment_status]],
					:items => full_order(order),
					:receipt_url => order[:receipt_url],
					address: {
						:name => order[:name],
						:city => order[:city],
						:country => order[:country],
						:line1 => order[:line1],
						:line2 => order[:line2],
						:postal_code => order[:postal_code]
					}
				}
			}, shipping_status: :ok
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
		order = Order.find(params[:id])
		if !order
			render json: {
				message: "Order #{params[:id]} not found.",
				data: order[:shipping_status],
			}, status: :not_acceptable
		else
			if params[:op] == "next"
				shipping_status = Order.shipping_statuses[order[:shipping_status]] + 1
			elsif params[:op] == "previous"
				shipping_status = Order.shipping_statuses[order[:shipping_status]] - 1
			else
				render json: {
					message: "Update operation not supported.",
					data: order[:shipping_status],
				}, status: :not_acceptable
			end

			if shipping_status < 0 || shipping_status > Order.shipping_statuses.length
				render json: {
					message: "Shipping status #{shipping_status} not valid.",
					data: order[:shipping_status],
				}, status: :not_acceptable
			else
				if order.update_columns(shipping_status: Order.shipping_statuses.key(shipping_status))
					render json: {
						message: "Shipping status correctly updated",
						data: shipping_status,
					}, status: :ok
				else
					render json: {
						message: "Could not update the shipping status",
						data: order[:shipping_status],
					}, status: :not_acceptable
				end
			end
		end
	end
end

private

def full_order(order)
	order.products.map{ |p|
		# Get the product
		product = Product.where(id:p[:id]).first
		product_json = JSON.parse(product.to_json)
		product_json[:images] = []
		# Get the first image of the product and push to images array
		if product.images.attached?
			product_json[:images].push({ url: url_for(product.images.first), id: product.images.first.id })
		end
		{
			:product => product_json,
			:quantity => OrderProduct.find_by(product_id: p[:id],order_id:order[:id])[:quantity]
		}
	}
end

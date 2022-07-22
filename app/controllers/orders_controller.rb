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
	
	
	def search
		authorize! :read, Order, :message => "BEWARE: you are not authorized to read orders."
		# Search for orders of current user by id or by product name in the order
		all_orders = Order.where(user_id: current_user.id, payment_status: [:paid, :paid_client])
		if params[:search] != ""
			# If string starts with a #, remove it and search for order id
			if params[:search][0] == "#"
				params[:search] = params[:search][1..-1]
			end
			# Search for order id
			orders = all_orders.where(id: params[:search])
			# If no order id found, search for product name
			if !orders.empty?
				orders = orders.map { |o|
					{
						:id => o[:id],
						:shipping_status => Order.shipping_statuses[o[:shipping_status]],
						:payment_status => Order.payment_statuses[o[:payment_status]],
						:items => full_order(o)
					}
				}
			else
				orders = []
				all_orders.each do |o|
					puts "Searching in order #{o[:id]}"
					# For each order, get the items and search for the product name
					items = full_order(o)
					# If product name found, add the order to the list
					items.each do |item|
						if item[:product]["name"].downcase.include? params[:search].downcase
							# Add the order to the list
							orders << {
								:id => o[:id],
								:shipping_status => Order.shipping_statuses[o[:shipping_status]],
								:payment_status => Order.payment_statuses[o[:payment_status]],
								:items => items
							}
							break
						end
					end					
				end
			end
		else
			orders = all_orders.map { |o|
				{
					:id => o[:id],
					:shipping_status => Order.shipping_statuses[o[:shipping_status]],
					:payment_status => Order.payment_statuses[o[:payment_status]],
					:items => full_order(o)
				}
			}
		end
		render json: { data: orders}, status: :ok
	end



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

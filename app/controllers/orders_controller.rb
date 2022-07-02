class OrdersController < ApplicationController
	before_action :set_order, only: %i[ show edit update ]

    def index
        id_user = params[:user_id]
        orders = Order.where(user_id: id_user)
		user_order = orders.map do |u|
			{ :id => u.id, :products => u.products }
		  end
        render json: { data: user_order} 
    end

	def show
        x=  @order[:user_id]
        y = params[:user_id]

        if x.to_s == y.to_s
            	render json: { message: "ok.", data: @order.products }, status: :ok
        else
            render json: { message: "This user is not allowed to see this order." }, status: :not_acceptable
        end
	end
	
	def new
		id_user = params[:user_id]
		@product = User.find(id_user)
		@review = Order.new
	end
	
	def create
		prod = params[:products]
		@order = Order.new(user_id:params[:user_id])
		if @order.save
			prod.each{|p|
				op = OrderProduct.new(order_id:@order[:id],product_id:p[:id],quantity:p[:quantity])
				if op.save
					puts "prodotto aggiunto all ordine" 
				else 
					puts "non aggiunto" #si puo fare il rollback
				end
			}
            render json: { message: "Order added.", data: @order }, status: :ok
		else
			render json: { message: "Could not add order", data: @order.errors }, status: :not_acceptable
		end
	end




	private
	# Use callbacks to share common setup or constraints between actions.
	def set_order
		@order = Order.find(params[:id])
	end

	def order_params
		params.require(:order).permit(:user_id)
	end
end

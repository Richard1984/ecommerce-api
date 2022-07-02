class OrdersController < ApplicationController
	before_action :set_review, only: %i[ show edit update ]

    def index
        id_user = params[:user_id]
        user_order = Order.where(user_id: id_user).group_by {|o| o}
        render json: { data: user_order} 
    end

	def show
        x=  @order[:user_id]
        y = params[:user_id]
     
        if x.to_s == y.to_s
            render json: { message: "ok.", data: @order }, status: :ok
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
		id_product = params[:product_id]
		@product = Product.find(id_product)
		id_user = params[:order][:user_id]
		@user = User.find(id_user)

		@order = Order.new(order_params)
		@order.product = @product
		if @order.save
            render json: { message: "Order added.", data: @order }, status: :ok
		else
			render json: { message: "Could not add order", data: @order.errors }, status: :not_acceptable
		end
	end




	private
	# Use callbacks to share common setup or constraints between actions.
	def set_review
		@order = Order.find(params[:id])
	end

	def order_params
		params.require(:order).permit(:product_id,:user_id,:id)
	end
end
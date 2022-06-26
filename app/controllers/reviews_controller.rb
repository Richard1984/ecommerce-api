class ReviewsController < ApplicationController
	# before_action :authenticate_user! #forza autenticazione
	
	def new
		id_product = params[:product_id]
		@product = Product.find(id_product)
		# @users = User.all
		@review = Review.new
	end
	
	def create
		id_product = params[:product_id]
		@product = Product.find(id_product)
		id_user = params[:review][:user_id]
		@user = User.find(id_user)
		# @users = User.all
		@review = Review.new(review_params)
		@review.product = @product
		if @review.save
            render json: { message: "Review added." }, status: :ok
		else
			render json: { message: "Review added failure."}, status: :not_acceptable # come restituire errore generato da review model?
		end
	end

	def review_params
		params.require(:review).permit(:stars, :comments, :user_id)
	end
end
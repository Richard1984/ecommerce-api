class ReviewsController < ApplicationController
	# TODO: valutazione recensione
	# before_action :authenticate_user! #forza autenticazione
	before_action :set_review, only: %i[ show edit update ]

	def index
		@reviews = Review.where(product_id: params[:product_id])
		render json: { data: @reviews }
	end

	def show
		render json: { data: @review }
	end
	
	def new
		id_product = params[:product_id]
		@product = Product.find(id_product)
		# @users = User.all
		@review = Review.new
	end

	def edit
	end
	
	def create
		#authorize! :create, @review, :message => "BEWARE: you are not authorized to create new reviews."

		id_product = params[:product_id]
		@product = Product.find(id_product)
		id_user = params[:review][:user_id]
		@user = User.find(id_user)
		# @users = User.all
		@review = Review.new(review_params)
		@review.product = @product
		if @review.save
            render json: { message: "Review added.", data: @review }, status: :ok
		else
			render json: { message: "Could not add review", data: @review.errors }, status: :not_acceptable
		end
	end

	def update
		#authorize! :update, @movie, :message => "BEWARE: you are not authorized to update existing movies."

		if @review.update(review_params)
			render json: { message: "Review was successfully updated.", data: @review }, status: :ok
		else
			render json: { message: "Could not update review", data: @review.errors }, status: :not_acceptable
		end
	end

	# NON E' tra le user stories
	# def destroy
	# 	#authorize! :destroy, @review, :message => "BEWARE: you are not authorized to destroy existing reviews."
		
	# 	@review.destroy
	
	# 	render json: { message: "Review deleted." }, status: :ok
	# end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_review
		@review = Review.find(params[:id])
	end

	def review_params
		params.require(:review).permit(:stars, :comments, :user_id)
	end
end
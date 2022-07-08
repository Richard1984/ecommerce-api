class ReviewsController < ApplicationController
	# TODO: valutazione recensione
	# before_action :authenticate_user! #forza autenticazione
	before_action :set_review, only: %i[ show edit update ]

	def index
		authorize! :read, Review, :message => "BEWARE: you are not authorized to read reviews."
		@reviews = Review.where(product_id: params[:product_id])
		render json: { data: @reviews }
	end

	def show
		authorize! :read, Review, :message => "BEWARE: you are not authorized to read reviews."
		render json: { data: @review }
	end
	
	def create
		authorize! :create, Review, :message => "BEWARE: you are not authorized to create reviews."

		@review = Review.new(review_params)
		@review.product_id = params[:product_id]
		if @review.save
            render json: { message: "Review added.", data: @review }, status: :ok
		else
			render json: { message: "Could not add review", data: @review.errors }, status: :not_acceptable
		end
	end

	def update
		authorize! :update, Review, :message => "BEWARE: you are not authorized to update reviews."

		if @review.update(review_params)
			render json: { message: "Review was successfully updated.", data: @review }, status: :ok
		else
			render json: { message: "Could not update review", data: @review.errors }, status: :not_acceptable
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_review
		@review = Review.find(params[:id])
	end

	def review_params
		params.require(:review).permit(:stars, :comments, :user_id)
	end
end
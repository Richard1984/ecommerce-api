class ReviewsController < ApplicationController
	before_action :set_review, only: %i[ show edit update ]

	def index
		authorize! :read, Review, :message => "BEWARE: you are not authorized to read reviews."
		@reviews = Review.where(product_id: params[:product_id])

		reviews_json = @reviews.map do |review|
			add_user_info_votes(review)
		end

		render json: { data: reviews_json }
	end

	def show
		authorize! :read, Review, :message => "BEWARE: you are not authorized to read reviews."
		render json: { data: add_user_info_votes(@review) }
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
		params.require(:review).permit(:stars, :comments).merge(user_id: current_user.id)
	end

	def add_user_info_votes(review)
		review_json = JSON.parse(review.to_json)
		review_json[:user] = {
			firstname: review.user.firstname,
			lastname: review.user.lastname,
			roles: review.user.roles,
			avatar: review.user.avatar.attached? ? url_for(review.user.avatar) : nil
		}
		votes = review.total_likes_dislikes
		review_json[:votes] = {
			likes: votes[0],
			dislikes: votes[1]
		}
		return review_json
	end
end
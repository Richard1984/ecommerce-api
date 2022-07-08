class VotesController < ApplicationController
	# before_action :authenticate_user! #forza autenticazione
    before_action :vote_params
	before_action :set_vote, only: %i[ show edit update destroy]

	def show
        authorize! :read, Vote, :message => "BEWARE: you are not authorized to read votes."
		render json: { data: @vote }
	end
	
	def create
		authorize! :create, Vote, :message => "BEWARE: you are not authorized to create votes."

        # { ... "vote": { "likes": true } ... }
		@vote = Vote.new(review_id: @review, user_id: @user, likes: @likes)
		if @vote.save
            render json: { message: "Vote saved.", data: @vote }, status: :ok
		else
			render json: { message: "Could not save vote", data: @vote.errors }, status: :not_acceptable
		end
	end

	def update
		authorize! :update, Vote, :message => "BEWARE: you are not authorized to update votes."

		if @vote.update(params.require(:vote).permit(:likes))
			render json: { message: "Vote was successfully updated.", data: @vote }, status: :ok
		else
			render json: { message: "Could not update vote", data: @vote.errors }, status: :not_acceptable
		end
	end

    def destroy
		authorize! :destroy, Vote, :message => "BEWARE: you are not authorized to delete votes."

        if @vote.update(likes: nil)
            render json: { message: "Vote was successfully deleted.", data: @vote }, status: :ok
        else
			render json: { message: "Could not delete vote", data: @vote.errors }, status: :not_acceptable
		end
    end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_vote
		@vote = Vote.find_by(review_id: @review, user_id: @user)
	end

    def vote_params
        @review = params[:review_id]
        @user = current_user.id
        @likes = params[:likes]
    end
end
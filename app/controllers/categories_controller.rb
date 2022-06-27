class CategoriesController < ApplicationController
    
    def index
        render json: { data: Category.all }
    end

    def new
		@category = Category.new
	end
	
	def create
		#authorize! :create, @review, :message => "BEWARE: you are not authorized to create new reviews."

		@category = Category.new(params.require(:category).permit(:name))
		if @category.save
            render json: { message: "Category added.", data: @category }, status: :ok
		else
			render json: { message: "Could not add category", data: @category.errors }, status: :not_acceptable
		end
	end

	# NON E' tra le user stories
	def destroy
		#authorize! :destroy, @review, :message => "BEWARE: you are not authorized to destroy existing reviews."

        @category = Category.find(params[:id])
		@category.destroy
	
		render json: { message: "Category deleted." }, status: :ok
	end
end
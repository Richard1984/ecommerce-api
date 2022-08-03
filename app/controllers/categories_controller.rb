class CategoriesController < ApplicationController
    
    def index
		authorize! :read, Category, :message => "BEWARE: you are not authorized to read categories."
        render json: { data: Category.all }
    end
	
	def create
		authorize! :create, Category, :message => "BEWARE: you are not authorized to create categories."

		@category = Category.new(params.require(:category).permit(:name))
		if @category.save
            render json: { message: "Category added.", data: @category }, status: :ok
		else
			render json: { message: "Could not add category", data: @category.errors }, status: :not_acceptable
		end
	end

	def update
		authorize! :update, Category, :message => "BEWARE: you are not authorized to update categories."

		@category = Category.find(params[:id])
		if @category.update(params.require(:category).permit(:name))
			render json: { message: "Category was successfully updated.", data: @category }, status: :ok
		else
			render json: { message: "Could not update category", data: @category.errors }, status: :not_acceptable
		end
	end

	def destroy
		authorize! :destroy, Category, :message => "BEWARE: you are not authorized to delete categories."

        @category = Category.find(params[:id])
		# Imposta category_id=null ai prodotti che appartengono a questa categoria 
		Product.where(category_id: params[:id]).update_all(category_id: nil)
		@category.destroy
	
		render json: { message: "Category deleted." }, status: :ok
	end
end
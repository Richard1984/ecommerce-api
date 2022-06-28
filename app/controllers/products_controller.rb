class ProductsController < ApplicationController
    before_action :set_product, only: %i[ show edit update destroy]

    def index
        render json: { data: search_and_order }
    end

    def show
        render json: { data: @product }
	end
	
	def new
		@product = Product.new
	end

	def edit
	end
	
	def create
		#authorize! :create, @review, :message => "BEWARE: you are not authorized to create new reviews."

		@product = Product.new(product_params)
		if @product.save
            render json: { message: "Product added.", data: @product }, status: :ok
		else
			render json: { message: "Could not add product", data: @product.errors }, status: :not_acceptable
		end
	end

	def update
		#authorize! :update, @movie, :message => "BEWARE: you are not authorized to update existing movies."

		if @product.update(product_params)
			render json: { message: "Product was successfully updated.", data: @product }, status: :ok
		else
			render json: { message: "Could not update product", data: @product.errors }, status: :not_acceptable
		end
	end

	def destroy
		#authorize! :destroy, @review, :message => "BEWARE: you are not authorized to destroy existing reviews."
		
		@product.destroy
	
		render json: { message: "Product deleted." }, status: :ok
	end

    
    
	private

	def set_product
		@product = Product.find(params[:id])
	end

	def product_params
        params.require(:product).permit(:name, :availability, :price, :description, :category_id)
	end

    def search_and_order

        # Forse si puo' fare piu' pulito
        category_id = params[:category_id]
        search_name = params[:search_name]
        if params[:sort]
            sorting_criteria = params[:sort][:criteria]
            sorting_order = params[:sort][:order] ? params[:sort][:order] : :asc # asc / desc
        else
            sorting_criteria = nil
            sorting_order = nil
        end

        @products = Product.all
        @products = @products.where(category_id: category_id) if category_id # Filter by category
        @products = @products.where("name like ?", "#{search_name}%") if search_name # Select starting by name
        @products = @products.order(sorting_criteria => sorting_order) if sorting_criteria # Sort
        return @products
    end
end

class ProductsController < ApplicationController
	before_action :set_product, only: %i[ show edit update destroy]

    def index
		authorize! :read, Product, :message => "BEWARE: you are not authorized to read products."
        render json: { data: search_and_order }
    end

    def show
		authorize! :read, @product, :message => "BEWARE: you are not authorized to read products."
		images = []
		if @product.images.attached?
			@product.images.each do |image|
				image_json = JSON.parse(image.to_json)
				image_json[:url] = url_for(image)
				images.push(image_json)
			end
		end
		product_json = JSON.parse(@product.to_json)
		product_json[:images] = images
		product_json[:avg_reviews] = @product.avg_reviews
        render json: { data: product_json }
	end
	
	def create
		authorize! :create, Product, :message => "BEWARE: you are not authorized to create products."

		# Per creare un prodotto con immagini devi prima fare un post sul prodotto e poi fare un post sulle immagini del prodotto
		@product = Product.new(product_params)
		if @product.save
            render json: { message: "Product added.", data: @product }, status: :ok
		else
			render json: { message: "Could not add product", data: @product.errors }, status: :not_acceptable
		end
	end

	def update
		authorize! :update, @product, :message => "BEWARE: you are not authorized to update products."

		if @product.update(product_params)
			render json: { message: "Product was successfully updated.", data: @product }, status: :ok
		else
			render json: { message: "Could not update product", data: @product.errors }, status: :not_acceptable
		end
	end

	def destroy
		authorize! :destroy, @product, :message => "BEWARE: you are not authorized to delete products."

		#@product.images.purge
		#@product.destroy

		# Forse cambiare la colonna availability in stock per evitare confusioni
		# Cambiare file user stories?
		@product.update(availability: 0, available: false)
	
		render json: { message: "Product is now unavailable.", data: @product }, status: :ok
	end

    def update_images
		authorize! :update, @product, :message => "BEWARE: you are not authorized to update products."
		# errori?
		product = Product.find(params[:product_id])
		product.images.attach(params[:images])
		render json: { message: "Images uploaded", images: product.images.attached? }
	end

	def destroy_images
		authorize! :update, @product, :message => "BEWARE: you are not authorized to update products."
		
		images_to_destroy = params[:images_ids]
		images_destroyed = []
		product = Product.find(params[:product_id])
		if images_to_destroy
			images_to_destroy.each do |i|
				image = product.images.find(i)
				if image
					image.purge
					images_destroyed.push(image)
				end
			end
		else
			product.images.each do |image|
				images_destroyed.push(image)
			end
			product.images.purge
		end

		render json: { message: "Images deleted", data: images_destroyed }
	end
    
	private

	def set_product
		@product = Product.find(params[:id])
	end

	def product_params
        params.require(:product).permit(:name, :availability, :price, :description, :category_id, :available)
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

        @products = Product.where(available: true) # index mostra solo i prodotti disponibili
        @products = @products.where(category_id: category_id) if category_id # Filter by category
        @products = @products.where("name like ?", "%#{search_name}%") if search_name # Select containing name
        @products = @products.order(sorting_criteria => sorting_order) if sorting_criteria # Sort
        return @products
    end
end

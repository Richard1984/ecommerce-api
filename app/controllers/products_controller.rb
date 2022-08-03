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
				images.push({ url: url_for(image), id: image.id })
			end
		end
		product_json = JSON.parse(@product.to_json)
		product_json[:category_name] = Category.find(@product.category_id).name if @product.category_id
		product_json[:images] = images
		product_json[:avg_reviews] = @product.avg_reviews
		product_json[:reviews_by_stars] = {
			"0": @product.reviews_by_star[0],
			"1": @product.reviews_by_star[1],
			"2": @product.reviews_by_star[2],
			"3": @product.reviews_by_star[3],
			"4": @product.reviews_by_star[4],
			"5": @product.reviews_by_star[5]
		}
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
	
		render json: { message: "Product successfully deleted.", data: @product }, status: :ok
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
        if params[:sort_criteria]
            sorting_criteria = params[:sort_criteria]
            sorting_order = params[:sort_order] ? params[:sort_order] : "asc" # asc / desc

			# Fix dangerous query method
			sorting_criteria = Arel.sql(sorting_criteria)
			sorting_order = Arel.sql(sorting_order)
        else
            sorting_criteria = nil
            sorting_order = nil
        end

        @products = Product.where(available: true) # index mostra solo i prodotti disponibili
        @products = @products.where(category_id: category_id) if category_id # Filter by category
        @products = @products.where("name like ?", "%#{search_name}%") if search_name # Select containing name
		# Sort
        if sorting_criteria == "total_ordered"
			# fare meglio?
			if sorting_order == "asc"
				@products = @products.sort { |p1,p2| p1.total_ordered <=> p2.total_ordered }
			else
				@products = @products.sort { |p1,p2| p2.total_ordered <=> p1.total_ordered }
			end
		elsif sorting_criteria
			@products = @products.order(sorting_criteria => sorting_order) 
		end
		prods = Array.new
	
		@products.each{ |product|
			images =[]
			if product.images.attached?
				product.images.each do |image|
					images.push({ url: url_for(image), id: image.id })
				end
			end
			
			product_json = JSON.parse(product.to_json)
			product_json[:images] =  images
			prods << product_json

		}
        return prods
    end
end

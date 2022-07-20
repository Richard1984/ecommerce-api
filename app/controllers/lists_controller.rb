class ListsController < ApplicationController

    def index
		authorize! :read, List, :message => "BEWARE: you do not have lists, since you are not logged in."

        lists = List.where(user_id: current_user.id)
		user_lists = lists.map do |l|
			{ :id => l.id, name: l.name }
		  end
        render json: { data: user_lists } 
    end

	def show
        authorize! :read, List, :message => "BEWARE: you do not have lists, since you are not logged in."

		list = List.find_by(id: params[:id], user_id: current_user.id)
        if list
			products = []
			list.products.each { |product|
				product_json = JSON.parse(product.to_json)
				product_json[:image] = url_for(product.images.first) if product.images.attached?
				products.push(product)
			}
            render json: { data: { list: list, products: products } }, status: :ok
        else
            render json: { message: "List #{params[:id]} for user #{current_user.email} not found." }, status: :not_found
        end
	end
	
	def create
		authorize! :create, List, :message => "BEWARE: you are not authorized to create lists."

		products = params[:products]
		name = params[:name] 
		if !name
			index = List.where(user_id: current_user.id).length + 1
			name = "List ##{index}" 
		end
		list = List.new(user_id: current_user.id, name: name)
		begin
			List.transaction do
				list.save!
				ListsEntry.transaction do
					products.each do |p|
						le = ListsEntry.find_by(list_id: list[:id], product_id: p)
						if !le # se il prodotto non e' gia' associato a questa lista lo aggiunge
							le = ListsEntry.new(list_id: list[:id], product_id: p)
							le.save!
						end
					end
				end
			end
		rescue Exception => e
            render json: { message: "Could not create list", data: e }, status: 500
		else
			render json: { message: "List created.", data: { list: list, products: list.products } }, status: :ok
		end
	end

    def update
        authorize! :update, List, :message => "BEWARE: you do not have lists, since you are not logged in."

        products_to_add = params[:products_to_add]
        products_to_delete = params[:products_to_delete]
		name = params[:name]
        list = List.find(params[:id])
        begin
			List.transaction do
				list.update(name: name)
				ListsEntry.transaction do
	                products_to_delete.each do |p|
						le = ListsEntry.find_by(list_id: list[:id], product_id: p)
						le.destroy if le # se il prodotto e' associato alla lista lo elimina
					end
					products_to_add.each do |p|
						le = ListsEntry.find_by(list_id: list[:id], product_id: p)
						if !le # se il prodotto non e' gia' associato a questa lista lo aggiunge
							le = ListsEntry.new(list_id: list[:id], product_id: p)
							le.save!
						end
					end
				end
			end
		rescue Exception => e
            render json: { message: "Could not update list", data: e }, status: 500
		else
			# da rifare meglio
			render json: { message: "List updated.", data: { list: list, products: list.products } }, status: :ok
		end
    end

    def destroy
        authorize! :destroy, List, :message => "BEWARE: you do not have lists, since you are not logged in."

        list = List.find(params[:id])
        begin
			List.transaction do
				ListsEntry.transaction do
					list.products.each do |p|
						ListsEntry.find_by(list_id: list[:id], product_id: p[:id]).destroy
					end
				end
                list.destroy
			end
		rescue Exception => e
            render json: { message: "Could not delete list", data: e }, status: 500
		else
			render json: { message: "List deleted." }, status: :ok
		end
    end
end
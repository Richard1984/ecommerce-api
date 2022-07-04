class ListsController < ApplicationController

    def index
        lists = List.where(user_id: current_user.id)
		user_lists = lists.map do |l|
			{ :id => l.id, :products => l.products }
		  end
        render json: { data: user_lists } 
    end

	def show
        # forse si puo fare il check con authorize?
		list = List.find_by(id: params[:id], user_id: current_user.id)
        if list
            render json: { data: list.products }, status: :ok
        else
            render json: { message: "List #{params[:id]} for user #{current_user.email} not found." }, status: :not_found
        end
	end
	
	def new
	end
	
	def create
		products = params[:products]
		list = List.new(user_id: current_user.id)
		begin
			List.transaction do
				list.save!
				ListsEntry.transaction do
					products.each do |p|
						le = ListsEntry.new(list_id: list[:id], product_id: p[:id])
						le.save!
					end
				end
			end
		rescue Exception => e
            render json: { message: "Could not create list", data: e }, status: 500
		else
			render json: { message: "List created.", data: list.products }, status: :ok
		end
	end

    def edit
    end

    def update
        # authorize

        products_to_add = params[:products_to_add]
        products_to_delete = params[:products_to_delete]
        list = List.find(params[:id])
        begin
			ListsEntry.transaction do
                products_to_delete.each do |p|
					ListsEntry.find_by(list_id: list[:id], product_id: p[:id]).destroy
				end
				products_to_add.each do |p|
					le = ListsEntry.new(list_id: list[:id], product_id: p[:id])
					le.save!
				end
			end
		rescue Exception => e
            render json: { message: "Could not update list", data: e }, status: 500
		else
			render json: { message: "List updated.", data: list.products }, status: :ok
		end
    end

    def destroy
        # authorize

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
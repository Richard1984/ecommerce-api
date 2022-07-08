class RemoveFilledFromCarts < ActiveRecord::Migration[7.0]
  def change
    remove_column :carts, :filled, :boolean
  end
end

class AddFilledToCarts < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :filled, :boolean
  end
end

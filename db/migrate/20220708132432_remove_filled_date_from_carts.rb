class RemoveFilledDateFromCarts < ActiveRecord::Migration[7.0]
  def change
    remove_column :carts, :filled_date, :datetime
  end
end

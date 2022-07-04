class AddFilledDateToCarts < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :filled_date, :datetime
  end
end

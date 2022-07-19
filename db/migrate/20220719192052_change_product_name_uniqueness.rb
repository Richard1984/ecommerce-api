class ChangeProductNameUniqueness < ActiveRecord::Migration[7.0]
  def change
    remove_index :products, :name
    add_index :products, :name
  end
end

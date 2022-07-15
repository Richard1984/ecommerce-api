class AddAddressToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :name, :string
    add_column :orders, :city, :string
    add_column :orders, :country, :string
    add_column :orders, :line1, :string
    add_column :orders, :line2, :string
    add_column :orders, :postal_code, :string
  end
end

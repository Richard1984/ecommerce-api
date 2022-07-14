class AddShippingStatusToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :shipping_status, :integer, default: 0
  end
end

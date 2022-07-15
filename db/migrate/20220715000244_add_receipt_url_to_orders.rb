class AddReceiptUrlToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :receipt_url, :string
  end
end

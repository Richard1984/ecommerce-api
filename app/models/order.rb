class Order < ApplicationRecord
	belongs_to :user, optional: true
    has_many :order_products
    has_many :products, through: :order_products
    enum payment_status: [:not_paid, :paid_client, :paid]
    enum shipping_status: [:not_shipped, :pending, :shipped, :delivered]
end
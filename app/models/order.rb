class Order < ApplicationRecord
	belongs_to :user, optional: true
    has_many :order_products
    has_many :products, through: :order_products
    enum payment_status: [:paid_not, :paid_client, :paid, :failed]
    enum shipping_status: [:shipped_not, :pending, :shipped, :delivered]
end
class Order < ApplicationRecord
	belongs_to :user # PROBLEMA: non si puo' eliminare l'user perche c'e' foreign key
    has_many :order_products
    has_many :products, through: :order_products
end
class Product < ApplicationRecord
    belongs_to :category, optional: true
    has_many :reviews, dependent: :destroy
	has_many_attached :images
    has_many :order_products
    has_many :orders, through: :order_products
	has_many :carts

    def non_negative_price_availability
        errors.add(:price, 'must be non negative') if
                price < 0
        errors.add(:availability, 'must be non negative') if
                availability < 0
    end
	
	def not_available
		errors.add(:available, 'number of available items must be 0 for it to be unavailable') if
				!available && availability > 0
	end

	validate :non_negative_price_availability
	validate :not_available

    def avg_reviews
		sum = 0
		self.reviews.each do |review|
			sum = sum + review.stars
		end
		if self.reviews.count>0
			return sum/self.reviews.count
		else
			return "--"
		end
	end

	def total_ordered
		sum = 0
		self.order_products.each do |op|
			sum = sum + op.quantity
		end
		return sum
	end
end

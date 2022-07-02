class Product < ApplicationRecord
    belongs_to :category, optional: true
    has_many :reviews, dependent: :destroy
	has_many_attached :images
    has_many :order_products # PROBLEMA: non si puo' eliminare il prodotto perche c'e' foreign key
    has_many :orders, through: :order_products

    def non_negative_price_availability
        errors.add(:price, 'must be non negative') if
                price < 0
        errors.add(:availability, 'must be non negative') if
                availability < 0
    end

	validate :non_negative_price_availability

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
end

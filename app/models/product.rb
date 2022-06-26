class Product < ApplicationRecord
    belongs_to :category
    has_many :reviews, dependent: :destroy

    # before_save :capitalize_name

    # def capitalize_name
    #     self.name = self.name.split(/\s+/).map(&:downcase).
    #       map(&:capitalize).join(' ')
    # end

    # model validation

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

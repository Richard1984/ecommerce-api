class Review < ApplicationRecord
    belongs_to :product
	belongs_to :user

    def stars_between_0_and_5
        errors.add(:stars, 'must be between 0 and 5') if
                stars < 0 || stars > 5
    end

    validate :stars_between_0_and_5
end
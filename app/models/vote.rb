class Vote < ApplicationRecord
    belongs_to :review
	belongs_to :user

    validates :review, uniqueness: { scope: :user,
        message: "only one vote per user per review, try modifying the vote you already submitted" }
end
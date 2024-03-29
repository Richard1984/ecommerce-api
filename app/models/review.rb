class Review < ApplicationRecord
    belongs_to :product
	belongs_to :user
    has_many :votes, dependent: :destroy

    def stars_between_0_and_5
        errors.add(:stars, 'must be between 0 and 5') if
                stars < 0 || stars > 5
    end

    validate :stars_between_0_and_5
    validates :product, uniqueness: { scope: :user,
        message: "only one review per user" }
    
    def total_likes_dislikes
        likes = dislikes = 0
        self.votes.each do |vote|
            vote.likes ? likes += 1 : dislikes += 1
        end

        return likes, dislikes
    end
end
class List < ApplicationRecord
	belongs_to :user
    has_many :lists_entries, dependent: :destroy
    has_many :products, through: :lists_entries
end
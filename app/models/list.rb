class List < ApplicationRecord
	belongs_to :user # PROBLEMA: non si puo' eliminare l'user perche c'e' foreign key
    has_many :lists_entries
    has_many :products, through: :lists_entries
end
class Category < ApplicationRecord
    has_many :products

    validates :name, uniqueness: { message: "this category already exists" }
end

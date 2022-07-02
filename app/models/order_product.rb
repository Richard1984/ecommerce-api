class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product # PROBLEMA: non si puo' eliminare il prodotto perche c'e' foreign key
end

class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :scheduled_delivery
end

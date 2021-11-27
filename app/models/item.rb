class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :price
  end

  validates_inclusion_of :price, in: 300..9_999_999, message: 'is out of setting range'
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters.' }

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  has_many_attached :images
  has_one :order
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :delivery_fee
  belongs_to :scheduled_delivery
  belongs_to :user
end

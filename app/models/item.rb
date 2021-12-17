class Item < ApplicationRecord
  has_many_attached :images
  has_one :order
  belongs_to :user
  has_many :item_tag_relations, dependent: :destroy
  has_many :tags, through: :item_tag_relations
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :delivery_fee
  belongs_to :scheduled_delivery
end

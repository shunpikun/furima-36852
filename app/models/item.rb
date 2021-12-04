class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  with_options presence: true do
    validates :images
    validates :name
    validates :info
    validates :price
  end

  validates_inclusion_of :price, in: 300..9_999_999, message: 'は¥300~¥9,999,999の範囲内で入力してください'
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'は半角数値で入力してください' }

  with_options numericality: { other_than: 1, message: "を選択してください" } do
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
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations
end

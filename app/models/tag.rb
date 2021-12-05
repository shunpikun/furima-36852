class Tag < ApplicationRecord
  has_many :item_tag_relations, dependent: :destroy
  has_many :posts, through: :item_tag_relations, dependent: :destroy
  validates :tag_name,  uniqueness: true
end

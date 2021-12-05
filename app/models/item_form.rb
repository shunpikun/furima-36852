class ItemForm
  include ActiveModel::Model
  #ItemFormクラスのオブジェクトがItemモデルの属性を扱えるようにする
  attr_accessor(
    :name, :info, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :scheduled_delivery_id, :price, :images, :user_id,
    :id, :created_at, :datetime, :updated_at, :datetime,
    :tag_name
  )

  with_options presence: true do
    validates :images
    validates :name
    validates :info
    validates :price
  end

  validates :price, numericality: {in: (300..9999999), message: 'は¥300~¥9,999,999の範囲内で入力してください'}
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'は半角数値で入力してください' }

  with_options numericality: { other_than: 1, message: "を選択してください" } do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  def save
    Item.create(name: name, images: images, info: info, category_id: category_id, condition_id: condition_id, delivery_fee_id: delivery_fee_id, prefecture_id: prefecture_id, scheduled_delivery_id: scheduled_delivery_id, price: price, user_id: user_id)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    PostTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

  def update(params, item)
    item.update(params)
  end
end
class ItemForm
  include ActiveModel::Model

  # ItemFormクラスのオブジェクトがItemモデルの属性を扱えるようにする
  attr_accessor(
    :name, :info, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :scheduled_delivery_id, :price, :images, :user_id,
    :id, :created_at, :datetime, :updated_at, :datetime,
    :tag_name
  )

  with_options presence: true do
    validates :images, length: { minimum: 1, maximum: 5, message: 'は1枚以上5枚以下にしてください' }
    validates :name
    validates :info
    validates :price
  end

  validates :price, numericality: { in: (300..9_999_999), message: 'は¥300~¥9,999,999の範囲内で入力してください' }
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'は半角数値で入力してください' }
  validates :category_id, numericality: { message: 'を選択してください' }
  validates :condition_id, numericality: { message: 'を選択してください' }

  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :delivery_fee_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  def save
    item = Item.create(name: name, images: images, info: info, category_id: category_id, condition_id: condition_id,
                       delivery_fee_id: delivery_fee_id, prefecture_id: prefecture_id, scheduled_delivery_id: scheduled_delivery_id, price: price, user_id: user_id)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

  def update(params, item)
    # 一度タグの紐付けを消す
    item.item_tag_relations.destroy_all

    # paramsの中のタグの情報を削除。同時に、返り値としてタグの情報を変数に代入
    item_name = params.delete(:tag_name)

    # もしタグの情報がすでに保存されていればインスタンスを取得、無ければインスタンスを新規作成
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?

    # タグを保存
    tag.save if tag_name.present?
    item.update(params)
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id) if tag_name.present?
  end
end

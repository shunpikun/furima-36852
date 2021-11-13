class OrderAddress
  include Active::Model
  atter_accessor :postal_code, :prefecture, :city, :house_number, :building_name, :phone_number, :order, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :house_number
    validates :phone_number, numericality: {with: /\A\d{10,11}\z/, only_integer: true}
    validates :user_id
    validates :item_id
  end

  validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
end
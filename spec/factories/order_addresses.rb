FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { '10' }
    city { '日光市' }
    house_number { '2-2' }
    building_name { '日光ハイツ201号室' }
    phone_number { '01044030987' }
  end
end
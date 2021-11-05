FactoryBot.define do
  factory :item do
    name { 'ベッド' }
    info { '羽毛布団がついてきます！' }
    category_id { '2' }
    condition_id { '2' }
    delivery_fee_id { '2' }
    prefecture_id { '2' }
    scheduled_delivery_id { '2' }
    price { '20000' }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

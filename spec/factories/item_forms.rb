FactoryBot.define do
  factory :item_form do
    name { 'ベッド' }
    info { '羽毛布団がついてきます！' }
    category_id { '2' }
    condition_id { '2' }
    delivery_fee_id { '2' }
    prefecture_id { '2' }
    scheduled_delivery_id { '2' }
    price { '20000' }
    
  end
end

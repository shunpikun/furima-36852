FactoryBot.define do
  factory :user do
    nickname { 'gorou' }
    email { Faker::Internet.free_email }
    password { 'pass1234' }
    password_confirmation { 'pass1234' }
    first_name { '五郎' }
    first_name_kana { 'ゴロウ' }
    last_name { '田中' }
    last_name_kana { 'タナカ' }
    birth_date { '1993-09-06' }
  end
end

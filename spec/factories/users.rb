FactoryBot.define do
  factory :user do
    nickname { 'gorou' }
    email { 'test@example' }
    password { 'test1234' }
    password_confirmation { password }
    first_name { '五郎' }
    last_name { '田中' }
    first_name_kana { 'ゴロウ' }
    last_name_kana { 'タナカ' }
    birth_date { '1993-09-06' }
  end
end

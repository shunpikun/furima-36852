# テーブル設計

## users テーブル

| Column                 | Type       | Options             |
| ---------------------- | ---------- | ------------------- |
| nickname               | string     | null: false         |
| email                  | string     | null: false         |
| encrypted_password     | string     | null: false         |
| first_name             | string     | null: false         |
| last_name              | string     | null: false         |
| first_name_kana        | string     | null: false         |
| last_name_kana         | string     | null: false         |
| birth_date             | date       | null: false         |

### Association

- has_many :items
- has_one :order

## items テーブル

| Column                   | Type          | Options                        |
| ------------------------ | ------------- | ------------------------------ |
| name                     | string        | null: false                    |
| info                     | text          | null: false                    |
| category_id              | references    | null: false, foreign_key: true |
| condition_id             | references    | null: false, foreign_key: true |
| delivery_fee_id          | references    | null: false, foreign_key: true |
| prefecture_id            | references    | null: false, foreign_key: true |
| scheduled_delivery_id    | references    | null: false, foreign_key: true |
| price                    | integer       | null: false                    |
| user_id                  | references    | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user_id   | references | null: false, foreign_key: true |
| item_id   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| postal_code       | string     | null: false                    |
| prefecture        | string     | null: false                    |
| city              | string     | null: false                    |
| house_number      | string     | null: false                    |
| building_name     | string     |                                |
| phone_number      | integer    | null: false                    |

### Association 

- belongs_to :order
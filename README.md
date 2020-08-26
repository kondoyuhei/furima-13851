# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email    | string | null: false |
| password | string | null: false |
| name_sei | string | null: false |
| name_mei | string | null: false |
| yomi_sei | string | null: false |
| yomi_mei | string | null: false |
| birthday | date   | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| name      | string     | null: false                    |
| note      | text       | null: false                    |
| price     | integer    | null: false                    |
| image     | string     | null: false                    |
| user      | references | null: false, foreign_key: true |
| category  | integer    | null: false                    |
| condition | integer    | null: false                    |
| charge    | integer    | null: false                    |
| from      | integer    | null: false                    |
| period    | integer    | null: false                    |


### Association

- belongs_to :user
- has_one :purchase


## purchases テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign key: true |
| item      | references | null: false, foreign key: true |


### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping


## shippings テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| puchase    | references | null: false, foreign_key: true |
| zip        | string     | null: false                    |
| prefecture | integer    | null: false                    |
| city       | string     | null: false                    |
| address    | string     | null: false                    |
| building   | string     |                                |
| phone      | string     | null: false                    |


### Association

- belongs_to :purchase




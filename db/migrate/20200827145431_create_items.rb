class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :name,    null: false
      t.text       :note,      null: false
      t.integer    :price,     null: false
      t.references :user,      foreign_key: true
      t.integer    :category,  null: false
      t.integer    :condition, null: false
      t.integer    :charge,    null: false
      t.integer    :from,      null: false
      t.integer    :period,    null: false
      t.timestamps
    end
  end
end

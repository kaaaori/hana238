class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id,   null: false#会員ID
      t.string :postal_code,    null: false#郵便番号
      t.integer :prefecture_code,   null: false#県名
      t.string :address_city,   null: false#市区町村
      t.string :address_street, null: false#番地
      t.string :address_building,   null: false#建物
      t.string :address_name,   null: false#宛名
      t.integer :total,         null: false#商品合計
      t.integer :postage,       null: false#送料
      t.integer :payment_method,null: false#支払い方法
      t.date    :delivery_day,  null: false#配送日
      t.integer :delivery_time, null: false#配送時間
      t.timestamps
    end
  end
end

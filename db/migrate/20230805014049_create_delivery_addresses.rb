class CreateDeliveryAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_addresses do |t|
      t.integer :customer_id,   null: false#会員ID
      t.string :postal_code,    null: false#郵便番号
      t.integer :prefecture_code,   null: false#県名
      t.string :address_city,   null: false#市区町村
      t.string :address_street, null: false#番地
      t.string :address_building,   null: false#建物
      t.string :address_name,   null: false#宛名
      t.string :phone_number,   null: false#電話番号
      t.timestamps
    end
  end
end

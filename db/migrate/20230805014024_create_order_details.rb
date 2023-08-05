class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id,      null: false#注文ID
      t.integer :item_id,       null: false#商品ID
      t.integer :amount,        null: false#数量
      t.integer :price_intax,   null: false#税込み価格
      t.timestamps
    end
  end
end

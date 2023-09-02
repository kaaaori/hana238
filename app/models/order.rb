class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum delivery_time: { morning: 0, daytime: 1, afternoon: 2 }
  
  validates :customer_id, presence: true
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true
  validates :address_building, presence: true
  validates :address_name, presence: true
  validates :total, presence: true
  validates :postage, presence: true#配送料
  validates :payment_method, presence: true
  validates :delivery_day, presence: true
  validates :delivery_time, presence: true
  
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  
  def address
    '〒' + postal_code + ' '+ prefecture_name + ' ' + address_city + ' ' + address_street + ' ' + address_building
  end
  
end

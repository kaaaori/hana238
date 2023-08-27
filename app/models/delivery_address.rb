class DeliveryAddress < ApplicationRecord
  
  belongs_to :customer
  validates :customer_id, presence: true
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true
  validates :address_building, presence: true
  validates :address_name, presence: true
  validates :phone_number, presence: true
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  #https://qiita.com/yukihito_tomo/items/faa64f079617d92917be参照
  
  def address
    prefecture_name + ' ' + address_city + ' ' + address_street + ' ' + address_building
  end
end
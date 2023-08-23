class DeliveryAddress < ApplicationRecord
  
  belongs_to :customer
  
  def address
    prefecture_name + ' ' + address_city + ' ' + address_street + ' ' + address_building
  end
end

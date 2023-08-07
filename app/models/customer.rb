class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  # schemaでnull: falseの記入をしている為、改めてpresence: trueは不必要
  # validates :last_name, presence: true
  # validates :first_name, presence: true
  # validates :email, presence: true
  # validates :phone_number, presence: true
  # validates :postal_code, presence: true
  # validates :prefecture_code, presence: true
  # validates :address_city, presence: true
  # validates :address_street, presence: true
  
         
  include JpPrefecture
  jp_prefecture :prefecture_code

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

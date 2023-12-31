class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  validates :name, presence: true
  validates :category_id, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :inventory, presence: true
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  ## 消費税を求めるメソッド
  def with_tax_price
      (price * 1.1).floor
  end
  
  def enough_inventory?(amount)
    inventory - amount >= 0
  end
  
end

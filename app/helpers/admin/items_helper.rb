module Admin::ItemsHelper
  def admin_item_count(num)
    if num <= 0
      # カラー赤にしたい
      "soldout"
    else
      num
    end
  end
end

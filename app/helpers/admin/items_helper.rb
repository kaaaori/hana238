module Admin::ItemsHelper
  def admin_item_count(num)
    if num <= 0
      "在庫無し"
    else
      num
    end
  end
end

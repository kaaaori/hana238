class Public::ItemsController < ApplicationController
  def index
    @categories = Category.all
  end
  
  def show
    @categories = Category.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  private
    def category_params
      params.require(:category).permit(:name)
    end

end

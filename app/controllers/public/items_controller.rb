class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @categories = Category.all
    if params[:category]
      @category = Category.find(params[:category])
      @items = @category.items
    else
      @items = Item.all
    end
    
    @items = Item.page(params[:page]).per(4)
    ### @items = Item.order('id DESC').limit(8)
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
